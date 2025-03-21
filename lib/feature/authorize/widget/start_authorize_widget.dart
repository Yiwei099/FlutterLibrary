import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xiandun/feature/authorize/controller/authorize_controller.dart';
import 'package:xiandun/utils/icon_path.dart';
import 'package:xiandun/utils/image_path.dart';
import 'package:xiandun/utils/route_middleware.dart';
import 'package:xiandun/widget/com_app_bar.dart';

class StartAuthorizeWidget extends StatelessWidget {
  const StartAuthorizeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _convertWidget();
  }

  Widget _convertWidget() {
    return Scaffold(
      appBar: ComAppBar(title: '', showLeading: false),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagePath.bgHome),
                fit: BoxFit.fill, // 铺满
              ),
            ),
          ),
          Positioned(
            bottom: 90,
            left: 0,
            right: 0,
            child: Center(
              child: TextButton.icon(
                onPressed: () => {
                  go2Scan()
                },
                label: Text('快速授权', style: TextStyle(fontSize: 10.sp)),
                icon: Image.asset(IconPath.scan, width: 20, height: 20),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 80,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void go2Scan() {
    RouteMiddleWare.getInstance().doAfterLogin(pass: () {
      Get.find<AuthorizeController>().checkCameraPermission();
    });
  }
}
