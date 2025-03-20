import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiandun/utils/colors.dart';
import 'package:xiandun/utils/icon_path.dart';
import 'package:xiandun/utils/image_path.dart';
import 'package:xiandun/widget/com_app_bar.dart';

class AuthorizeDetailScreen extends StatefulWidget {
  const AuthorizeDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AuthorizeDetailScreenState();
}

class _AuthorizeDetailScreenState extends State<AuthorizeDetailScreen> {
  // late AuthorizeController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = Get.find<AuthorizeController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ComAppBar(title: '授权详情'),
      body: SafeArea(child: _convertWidget()),
    );
  }

  Widget _convertWidget() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [_convertAuthorizeMsg(), _convertCarPreviewWidget()],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: MyColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              minimumSize: Size(double.infinity, 40),
            ),
            child: const Text('取消授权'),
          ),
        ),
      ],
    );
  }

  Widget _convertAuthorizeMsg() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(6.0),
          color: MyColors.primary,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 20),
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '授权信息',
                      style: TextStyle(
                        color: MyColors.black283043,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _convertOptionWidget('授权开始时间：', '2025-01-12'),
                    const SizedBox(height: 5),
                    _convertOptionWidget('授权结束时间：', '2025-09-12'),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '授权协议：',
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: MyColors.gray666666,fontSize: 8.sp),
                        ),
                        InkWell(
                          onTap: () => {
                            debugPrint('查看协议')
                          },
                          child: Row(
                            children: [
                              Text(
                                '查看协议',
                                style: TextStyle(color: MyColors.primary,fontSize: 8.sp),
                              ),
                              Image.asset(
                                IconPath.next,
                                width: 16,
                                height: 16,
                                color: MyColors.primary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '授权结果：',
                          style: TextStyle(color: MyColors.gray666666,fontSize: 8.sp),
                        ),
                        Expanded(child: Text('已授权',style: TextStyle(color: MyColors.green02B449,fontSize: 8.sp))),
                        InkWell(
                          onTap: () => {
                            debugPrint('查看证书')
                          },
                          child: Row(
                            children: [
                              Text(
                                '查看证书',
                                style: TextStyle(color: MyColors.primary,fontSize: 8.sp),
                              ),
                              Image.asset(
                                IconPath.next,
                                width: 16,
                                height: 16,
                                color: MyColors.primary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '确权结果：',
                          style: TextStyle(color: MyColors.gray666666,fontSize: 8.sp),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () => {
                            debugPrint('去确认')
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              color: MyColors.primary,
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  '去确认信息',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Image.asset(
                                  IconPath.next,
                                  width: 16,
                                  height: 16,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Image.asset(ImagePath.fox),
              ),
            ],
          ),
        ),
        Positioned(
          right: 6,
          child: Image.asset(IconPath.badge, width: 80, height: 80),
        ),
      ],
    );
  }

  Widget _convertCarPreviewWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 90),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [MyColors.primary, MyColors.blueD8E3FF, Colors.white],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(IconPath.listCar, width: 26, height: 26),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '车辆相关信息',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w500,
                        fontSize: 8.sp,
                      ),
                    ),
                    const SizedBox(height: 5),
                    _convertDataMsgTextWidget('车架号：83294732472390723'),
                    const SizedBox(height: 5),
                    _convertDataMsgTextWidget('车辆品牌：上汽大众'),
                    const SizedBox(height: 5),
                    _convertDataMsgTextWidget('车辆型号：迈腾'),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: Divider(color: MyColors.grayF1f1f1, height: 1),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(IconPath.listAuthorize, width: 26, height: 26),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '车辆授权数据',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w500,
                        fontSize: 8.sp,
                      ),
                    ),
                    const SizedBox(height: 5),
                    _convertDataMsgTextWidget('数据类型：车辆诊断数据（共7份）'),
                    const SizedBox(height: 5),
                    _convertDataMsgTextWidget('最后诊断时间：2023-10'),
                    const SizedBox(height: 5),
                    _convertDataMsgTextWidget('数据授权用途：二手车交易'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _convertDataMsgTextWidget(String content) {
    return Text(
      content,
      style: TextStyle(color: MyColors.gray666666, fontSize: 8.sp),
    );
  }

  Widget _convertOptionWidget(String hint, String content) {
    return Row(
      children: [
        Expanded(
          flex: 33,
          child: Text(
            hint,
            style: TextStyle(color: MyColors.gray666666, fontSize: 8.sp),
          ),
        ),
        Expanded(
          flex: 67,
          child: Text(
            content,
            style: TextStyle(color: MyColors.black283043, fontSize: 8.sp),
          ),
        ),
      ],
    );
  }
}
