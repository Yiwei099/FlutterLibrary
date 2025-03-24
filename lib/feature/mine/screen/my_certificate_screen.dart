import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiandun/constants/constants.dart';
import 'package:xiandun/utils/channel_manager.dart';
import 'package:xiandun/utils/colors.dart';
import 'package:xiandun/utils/image_path.dart';
import 'package:xiandun/widget/com_app_bar.dart';

/// 查看个人证书
class MyCertificateScreen extends StatefulWidget {
  const MyCertificateScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MyCertificateScreenState();
}

class _MyCertificateScreenState extends State<MyCertificateScreen> {
  @override
  void initState() {
    super.initState();
    var result = ChannelManager.getInstance().getCertificateKey({
      Constants.bundleData: '',
    });

    if (result != null) {
      Future<String> tempResult = result as Future<String>;
      tempResult.then((result) {
        //证书数据
        debugPrint('证书数据：$result');
      }).catchError((onError) {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ComAppBar(title: '个人证书查看'),
      body: _convertBodyWidget(),
    );
  }

  Widget _convertBodyWidget() {
    return Stack(
      children: [
        Positioned(child: Container(color: MyColors.primary)),
        Container(
          width: double.infinity,
          height: 500,
          margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(ImagePath.bgCertificate)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 280, left: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _convertCertificateMsgTextWidget('证书版本：3'),
                const SizedBox(height: 20),
                _convertCertificateMsgTextWidget('证书序列号：34331231243'),
                const SizedBox(height: 20),
                _convertCertificateMsgTextWidget('证书有效期：2023-01-01至2025-01-01'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _convertCertificateMsgTextWidget(String content) {
    return Text(
      content,
      style: TextStyle(
        color: MyColors.color485473,
        fontSize: 8.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
