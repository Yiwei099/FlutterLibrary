import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  //<editor-fold desc="单例的实现"》
  //静态属性——该类的实例
  static PermissionUtil? _instance;

  //私有的命名构造函数，确保类不能从外部被实例化
  PermissionUtil._internal();

  static PermissionUtil getInstance() {
    _instance ??= PermissionUtil._internal();
    return _instance!;
  }

  //</editor-fold desc="单例的实现"》

  Future<bool> checkCameraPermission() async {
    // 检查相机权限
    final status = await Permission.camera.status;
    if (status.isGranted) {
      // 已经授权，可以进行相机操作
      debugPrint('相机权限已授权');
      return true;
    }

    if (status.isDenied) {
      // 拒绝授权，需要请求权限
      debugPrint('相机权限被拒绝');
      // 请求相机权限
      final result = await Permission.camera.request();
      if (result.isGranted) {
        return true;
      }

      Fluttertoast.showToast(
        msg: '授权相机权限后才允许使用该功能',
        toastLength: Toast.LENGTH_SHORT,
      );

      return false;
    }

    return false;
  }

  Future<bool> checkStoragePermission() async {
    final status = await Permission.storage.status;
    if (status.isGranted) {
      // 已经授权，可以进行相机操作
      debugPrint('全部文件权限已授权');
      return true;
    }

    if (status.isDenied) {
      // 拒绝授权，需要请求权限
      debugPrint('未获得全部文件权限');
      // 请求相机权限
      final result = await Permission.storage.request();
      if (result.isGranted) {
        return true;
      }

      Fluttertoast.showToast(
        msg: '为确保应用正常运行，请允许全部文件权限',
        toastLength: Toast.LENGTH_SHORT,
      );

      return false;
    }

    return false;
  }
}
