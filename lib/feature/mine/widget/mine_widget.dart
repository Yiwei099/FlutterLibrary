import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xiandun/constants/global_data_manager.dart';
import 'package:xiandun/constants/route.dart';
import 'package:xiandun/feature/home/controller/home_controller.dart';
import 'package:xiandun/utils/colors.dart';
import 'package:xiandun/utils/icon_path.dart';
import 'package:xiandun/utils/route_middleware.dart';
import 'package:xiandun/widget/com_app_bar.dart';

import '../../../bean/personal_center_function.dart';
import '../../../utils/image_path.dart';

class MineWidget extends StatefulWidget {
  const MineWidget({super.key});

  @override
  State<StatefulWidget> createState() => _MineWidgetState();
}

class _MineWidgetState extends State<MineWidget> {
  late HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<HomeController>();
  }

  final List<PersonalCenterFunction> _functionArr = [
    PersonalCenterFunction(
      title: '个人证书查看',
      icon: IconPath.certificate,
      onTap:
          () => {
            RouteMiddleWare.getInstance().redirectAfterLogin(
              name: Routes.myCertificate,
            ),
          },
    ),
    PersonalCenterFunction(
      title: '设置',
      icon: IconPath.setting,
      onTap:
          () => {
            RouteMiddleWare.getInstance().redirectAfterLogin(
              name: Routes.setting,
            ),
          },
    ),
    PersonalCenterFunction(
      title: '关于',
      icon: IconPath.about,
      onTap: () => {Get.toNamed(Routes.about)},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _convertWidget();
  }

  Widget _convertWidget() {
    return Scaffold(
      appBar: ComAppBar(title: '个人中心', showLeading: false),
      body: _convertBody(),
    );
  }

  Widget _convertBody() {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(children: [_convertBannerHeader(), _convertFunctionList()]),
    );
  }

  Widget _convertBannerHeader() {
    return InkWell(
      onTap:
          () => {
            RouteMiddleWare.getInstance().redirectAfterLogin(
              name: Routes.profile,
              getResult: (result){
              }
            ),
          },
      child: Container(
        // padding: EdgeInsets.only(top: 30, left: 20,right: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.bannerMine),
            fit: BoxFit.fill, // 铺满
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(IconPath.profile),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Obx(() {
                      return Text(
                        _controller.nickName.value,
                        style: TextStyle(color: Colors.white, fontSize: 8.sp),
                      );
                    }),
                  ),
                  Row(
                    children: [
                      Text(
                        '编辑',
                        style: TextStyle(color: Colors.white, fontSize: 6.sp),
                      ),
                      const SizedBox(width: 10),
                      Image.asset(IconPath.nextV1, width: 10, height: 10),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 10,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _convertFunctionList() {
    return Column(children: _convertFunctionItem());
  }

  List<Widget> _convertFunctionItem() {
    List<Widget> result = [];
    for (var item in _functionArr) {
      result.add(
        Padding(
          padding: EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 6),
          child: Column(
            children: [
              InkWell(
                onTap: () => {item.onTap()},
                child: Row(
                  children: [
                    Image.asset(item.icon, width: 30, height: 30),
                    const SizedBox(width: 5),
                    Expanded(child: Text(item.title)),
                    const SizedBox(width: 5),
                    Image.asset(IconPath.next, width: 10, height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Divider(height: 1, color: MyColors.colorECECEC),
            ],
          ),
        ),
      );
    }
    return result;
  }

  void _go2Notice() {
    print('消息通知');
  }
}
