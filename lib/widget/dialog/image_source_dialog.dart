import 'package:FlutterLibrary/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ImageSourceDialog extends StatelessWidget {
  final Function(int type) callBack;

  const ImageSourceDialog({super.key, required this.callBack});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '请选择',
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const Divider(height: 1, color: MyColors.colorECECEC),
          InkWell(
            onTap: () {
              Get.back();
              callBack(0);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
              child: Align(
                alignment: Alignment.center,
                child: Text('拍照'),
              ),
            ),
          ),
          const Divider(height: 1, color: MyColors.colorECECEC),
          InkWell(
            onTap: () {
              Get.back();
              callBack(1);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
              child: Align(
                alignment: Alignment.center,
                child: Text('从相册选择'),
              ),
            ),
          ),
          Container(
            height: 6,
            decoration: const BoxDecoration(color: MyColors.colorECECEC),
          ),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              child: Align(
                alignment: Alignment.center,
                child: Text('取消'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
