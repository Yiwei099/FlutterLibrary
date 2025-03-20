import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xiandun/constants/constants.dart';
import 'package:xiandun/constants/route.dart';
import 'package:xiandun/feature/mine/controller/about_controller.dart';
import 'package:xiandun/utils/colors.dart';
import 'package:xiandun/utils/icon_path.dart';
import 'package:xiandun/widget/com_app_bar.dart';
import 'package:xiandun/widget/com_option.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late AboutController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(AboutController());
    _controller.getVersion();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<AboutController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: ComAppBar(title: '关于'), body: _convertBodyWidget());
  }

  Widget _convertBodyWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ComOption(
            title: '用户协议',
            icon: Image.asset(IconPath.agreement, width: 24, height: 24),
              onTap: () {
                Get.toNamed(
                  Routes.webView,
                  arguments: {
                    Constants.bundleData: Constants.agreement,
                    Constants.bundleData1: '用户协议',
                  },
                );
              }
          ),
          ComOption(
            title: '隐私政策',
            icon: Image.asset(IconPath.privacy, width: 24, height: 24),
            onTap: () {
              Get.toNamed(
                Routes.webView,
                arguments: {
                  Constants.bundleData: Constants.urlPrivacy,
                  Constants.bundleData1: '隐私政策',
                },
              );
            },
          ),
          _convertCopyRightWidget(),
          Obx(() {
            return ComOption(
              title: '版本号',
              icon: Image.asset(IconPath.version, width: 24, height: 24),
              showNext: false,
              contentWidget: _convertValueTextWidget(_controller.version.value),
            );
          }),
          ComOption(
            title: '联系方式',
            icon: Image.asset(IconPath.contact, width: 24, height: 24),
            showDivider: false,
            showNext: false,
            contentWidget: _convertValueTextWidget('400-117-1166'),
          ),
        ],
      ),
    );
  }

  Widget _convertValueTextWidget(String v) {
    return Text(
      v,
      textAlign: TextAlign.end,
      style: TextStyle(fontSize: 8.sp, color: MyColors.colorAAAAAA),
    );
  }

  Widget _convertCopyRightWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(IconPath.copyright, width: 24, height: 24),
              const SizedBox(width: 10),
              Text('版权所有'),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _convertValueTextWidget('北京天天世纪数据技术有限公司'),
                    _convertValueTextWidget('北京中盾安信科技发展有限公司'),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(height: 20),
              Divider(height: 1, color: MyColors.colorECECEC),
            ],
          ),
        ],
      ),
    );
  }
}
