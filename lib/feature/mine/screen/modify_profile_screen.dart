import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xiandun/feature/home/controller/home_controller.dart';
import 'package:xiandun/feature/mine/controller/mine_controller.dart';
import 'package:xiandun/widget/com_app_bar.dart';

import '../../../utils/colors.dart';

/// 设置昵称
class ModifyProfileScreen extends StatefulWidget {
  const ModifyProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ModifyProfileScreenState();
}

class _ModifyProfileScreenState extends State<ModifyProfileScreen> {
  late MineController _controller;
  late HomeController _homeController;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(MineController());
    _homeController = Get.find<HomeController>();

    _controller.bindNickNameToTextController(_homeController.nickName.value);
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<MineController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: ComAppBar(title: '设置昵称',), body: _convertBody());
  }

  Widget _convertBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: TextField(
            controller: _controller.nickNameTextEditingController,
            maxLength: 8,
            maxLines: 1,
            decoration: InputDecoration(counterText: ''),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 10),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              '最多8个字',
              textAlign: TextAlign.end,
              style: TextStyle(color: MyColors.color8790B4, fontSize: 6.sp),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: TextButton(
            onPressed: () {
              _controller.submitUserInfo();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: MyColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              minimumSize: Size(double.infinity, 40),
            ),
            child: const Text('保存'),
          ),
        ),
      ],
    );
  }
}
