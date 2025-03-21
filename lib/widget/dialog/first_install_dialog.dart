import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xiandun/constants/constants.dart';
import 'package:xiandun/constants/route.dart';
import 'package:xiandun/utils/colors.dart';
import 'package:xiandun/utils/share_perferences_util.dart';

class FirstInstallDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  FirstInstallDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // 圆角
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '个人信息保护指引',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: MyColors.black333333,
              ),
            ),
            SizedBox(height: 16),
            _buildContent(),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // 退出应用
                    SystemNavigator.pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: MyColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: MyColors.primary),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text('不同意'),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () async {
                    await SharedPreferencesUtil.getInstance().setBool(Constants.spFirstInstall, false);
                    Get.back();
                    onConfirm();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: MyColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text('同意'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final TapGestureRecognizer _tgr1 = TapGestureRecognizer();
  final TapGestureRecognizer _tgr2 = TapGestureRecognizer();
  final TapGestureRecognizer _tgr3 = TapGestureRecognizer();

  Widget _buildContent() {
    return SizedBox(
      height: 250.h,
      child: ListView(
        children: [
          RichText(
            //必传文本
            text: TextSpan(
              text: "感谢您使用弦盾平台！我们非常重视您的个人信息和隐私保护。我们将通过",
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: "《弦盾用户协议》",
                  style: TextStyle(color: MyColors.primary),
                  recognizer: _tgr1
                    ..onTap = () {
                      _go2WebView(Constants.agreement,'弦盾用户协议');
                    },
                ),
                TextSpan(
                  text: "《弦盾隐私政策》",
                  style: TextStyle(color: MyColors.primary),
                  recognizer: _tgr2..onTap = () {_go2WebView(Constants.urlPrivacy,'弦盾隐私政策');},
                ),
                TextSpan(
                  text: "《弦盾免密登录服务协议》",
                  style: TextStyle(color: MyColors.primary),
                  recognizer: _tgr3..onTap = () {_go2WebView(Constants.noPasswordLoginPolicy,'弦盾免密登录服务协议');},
                ),
                TextSpan(
                  text: "帮助您了解我们如何收集、存储、使用、加工、传输、提供、公开、删除您的个人信息。\n",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text:
                  "1、 在您注册账号或使用弦盾提供的服务时，您需要向第三方SDK提供您的姓名、公民身份证号码、脸部信息，前述信息为您的敏感个人信息；\n",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text:
                  "2、 在您后续快速、便捷登录弦盾时，您需要提供您的脸部图像或视频进行人脸核验，或者需要提供您的指纹信息进行验证；\n",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: "3、 在您使用我们的产品或服务过程中，我们可能会收集您的设备信息及日志信息；\n",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text:
                  "4、 当您与弦盾的客服进行沟通时，为了方便与您联系或帮助您解决问题，保证您的账号安全，经过您的授权，弦盾会需要您提供必要的姓名、手机号码或电子邮件及其他联系方式等个人信息以供查询或核验您的身份；\n",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: "5、 我们在向您提供服务的过程中，基于服务的具体场景和功能，可能需要您开启一些设备访问权限收集信息。\n",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text:
                  "6、 为方便您清楚了解我们如何收集、存储、使用、加工、传输、提供、公开、删除您的个人信息，以及对您个人信息的保护措施，请您仔细阅读《弦盾用户协议》《弦盾隐私政策》《弦盾免密登录服务协议》。\n",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text:
                  "请您仔细阅读并理解《弦盾用户协议》《弦盾隐私政策》《弦盾免密登录服务协议》中关于您的个人信息的收集、存储、使用、加工、传输、提供、公开、删除政策以及保护措施，如您点击同意按钮即表示您已经同意上述协议及以上约定。\n",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _go2WebView(String url, String title) {
    Get.toNamed(Routes.webView, arguments: {
      Constants.bundleData: url,
      Constants.bundleData1: title
    });
  }
}
