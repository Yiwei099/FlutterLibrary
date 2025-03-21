
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xiandun/constants/constants.dart';
import 'package:xiandun/utils/share_perferences_util.dart';
import 'package:xiandun/widget/dialog/first_install_dialog.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var count = 1.obs;
  var title = ''.obs;

  final _titleArr = ['','授权','个人中心'];

  @override
  void onInit() async {
    super.onInit();

    await SharedPreferencesUtil.getInstance().init();
    isFirstRun();
  }

  void isFirstRun() {
    if (SharedPreferencesUtil.getInstance().getBool(Constants.spFirstInstall, defaultValue: true)) {
      //未同意协议
      _showFirstRunDialog();
    }else {
      //已同意协议
      _checkAllFilePermission();
    }
  }

  void _showFirstRunDialog() {
    Get.dialog(
      barrierDismissible: false,
      FirstInstallDialog(onConfirm: () {
        //开始业务逻辑
        _checkAllFilePermission();
      },),
    );
  }

  // 获取全部文件权限
  void _checkAllFilePermission() async{
    final status = await Permission.storage.status;
    if (status.isGranted) {
      // 已经授权，可以进行文件操作
      debugPrint('文件权限已授权');
    } else if (status.isDenied) {
      final result = await Permission.storage.request();
      if (result.isDenied) {
        // 申请后还被拒绝，直接打开设置
        if(Platform.isAndroid) {

        } else if (Platform.isIOS){

        }
      }
    }
  }

  void changeIndex(int index) {
    currentIndex.value = index;
    title.value = _titleArr[index];
  }
}