import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xiandun/utils/colors.dart';
import 'package:xiandun/utils/icon_path.dart';
import 'package:xiandun/widget/com_app_bar.dart';
import 'package:xiandun/widget/dialog/secondary_confirmation_dialog.dart';

///设置
class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return _convertWidget();
  }

  Widget _convertWidget() {
    return Scaffold(
      appBar: ComAppBar(
        title: '设置',
        actions: [
          IconButton(
            icon: Image.asset(IconPath.notice, width: 20, height: 20),
            onPressed: () {
              _go2Notice();
            },
          ),
        ],
      ),
      body: _convertBody(),
    );
  }

  Widget _convertBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              children: [
                Image.asset(IconPath.account, width: 24, height: 24),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '账号与安全',
                    style: TextStyle(
                      color: MyColors.color253764,
                      fontSize: 8.sp,
                    ),
                  ),
                ),
                Image.asset(IconPath.next, width: 16, height: 16),
              ],
            ),
          ),
          const SizedBox(height: 150),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextButton(
              onPressed: () {
                _logOut();
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
              child: const Text('退出登录'),
            ),
          ),
        ],
      ),
    );
  }

  void _go2Notice() {
    print('消息通知');
  }

  //自定义Dialog弹窗
  void _logOut() {
    Get.dialog(
      barrierDismissible:false,
      SecondaryConfirmationDialog(
        title: '提醒',
        content: '是否退出登录',
        onConfirm: () {},
      ),
    );
  }
}
