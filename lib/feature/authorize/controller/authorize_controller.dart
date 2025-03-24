import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xiandun/constants/global_data_manager.dart';
import 'package:xiandun/http/services/authorize_service.dart';

import '../../../constants/route.dart';

class AuthorizeController extends GetxController {
  late AuthorizeService authorizeService;

  var authorizeHistoryList = [].obs;

  var _pageIndex = 1;

  @override
  void onInit() {
    super.onInit();
    authorizeService = AuthorizeService();
  }

  void onRefreshAuthorizeHistoryData() {
    if (GlobalDataManager.getInstance().isLogin()) {
      getAuthorizeHistory(_pageIndex);
    } else {
      authorizeHistoryList.value = [];
    }
  }

  void getAuthorizeHistory(int pageNum) {
    authorizeService.getAuthorizeHistory(pageNum: pageNum, onSuccess: (pageIndex,onResponse) {
      _pageIndex ++;
      if(pageIndex == 1) {
        authorizeHistoryList.assignAll(onResponse.retList);
      } else {
        authorizeHistoryList.addAll(onResponse.retList);
      }
    });
  }

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
