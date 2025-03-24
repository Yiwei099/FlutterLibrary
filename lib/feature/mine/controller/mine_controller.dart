import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xiandun/constants/constants.dart';
import 'package:xiandun/constants/global_data_manager.dart';
import 'package:xiandun/http/services/home_service.dart';

class MineController extends GetxController {
  var avatar = ''.obs;

  final TextEditingController nickNameTextEditingController =
      TextEditingController();

  late HomeService homeService;

  @override
  void onInit() {
    super.onInit();
    homeService = HomeService();
    avatar.value = GlobalDataManager.getInstance().getUserInfo()?.avatar ?? '';
    nickNameTextEditingController.text =
        GlobalDataManager.getInstance().getUserInfo()?.nickname ?? '';
  }

  @override
  void onClose() {
    super.onClose();
    nickNameTextEditingController.dispose();
  }

  bindNickNameToTextController(String value) {
    nickNameTextEditingController.text = value;
  }

  submitUserInfo() {
    String nickName = nickNameTextEditingController.text;
    if (nickName.isEmpty) {
      return;
    }

    homeService.modifyUserInfo(nickName, avatar.value, (userInfo) {
      GlobalDataManager.getInstance().updateUserInfo(userInfo);
      Fluttertoast.showToast(
        msg: '修改成功',
        toastLength: Toast.LENGTH_SHORT,
      );
      Get.back(result: {Constants.resultData: true});
    }, () {});
  }
}
