import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xiandun/bean/authorize_history.dart';

import '../../../constants/route.dart';

class AuthorizeController extends GetxController {
  List<AuthorizeHistory> authorizeHistoryList = [
    AuthorizeHistory(
      vin: '123456789087976',
      authTime: '2023年10月10日',
      status: '1',
    ),
    AuthorizeHistory(
      vin: '443567654345324',
      authTime: '2023年11月11日',
      status: '-1',
      red: true,
    ),
    AuthorizeHistory(
      vin: '907878785677676',
      authTime: '2023年11月11日',
      status: '-2',
      red: true,
    ),
    AuthorizeHistory(
      vin: '967645645686656',
      authTime: '2023年11月11日',
      status: '-3',
      red: true,
    ),
    AuthorizeHistory(
      vin: '967645645686656',
      authTime: '2023年11月11日',
      status: '-3',
      red: true,
    ),
    AuthorizeHistory(
      vin: '967645645686656',
      authTime: '2023年11月11日',
      status: '-3',
      red: true,
    ),
    AuthorizeHistory(
      vin: '967645645686656',
      authTime: '2023年11月11日',
      status: '-3',
      red: true,
    ),
    AuthorizeHistory(
      vin: '967645645686656',
      authTime: '2023年11月11日',
      status: '-3',
      red: true,
    ),
    AuthorizeHistory(
      vin: '967645645686656',
      authTime: '2023年11月11日',
      status: '-3',
      red: true,
    ),
    AuthorizeHistory(
      vin: '967645645686656',
      authTime: '2023年11月11日',
      status: '-3',
      red: true,
    ),
    AuthorizeHistory(
      vin: '967645645686656',
      authTime: '2023年11月11日',
      status: '-3',
      red: true,
    ),
  ];

  void checkCameraPermission() async {
    // 检查相机权限
    final status = await Permission.camera.status;
    if (status.isGranted) {
      // 已经授权，可以进行相机操作
      debugPrint('相机权限已授权');
      final result = await Get.toNamed(Routes.scan);
      debugPrint('result from scan callBack：$result');
    } else if (status.isDenied) {
      // 拒绝授权，需要请求权限
      debugPrint('相机权限被拒绝');
      // 请求相机权限
      final result = await Permission.camera.request();
      if (result.isGranted) {
        final result = await Get.toNamed(Routes.scan);
        debugPrint('result from scan callBack：$result');
      }
    }
  }
}
