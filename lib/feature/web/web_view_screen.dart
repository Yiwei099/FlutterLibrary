import 'package:FlutterLibrary/constants/constants.dart';
import 'package:FlutterLibrary/feature/web/base_web_view_screen.dart';
import 'package:FlutterLibrary/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 仅加载 H5 通用 WebView，无 JS 交互，适合预览
/// 使用方式：
/// ```dart
///     Get.toNamed(
///      Routes.webView,
///      arguments: {
///        Constants.bundleData: 'https://www.baidu.com/', //H5链接
///        Constants.bundleData1: false, // 标题来源于 H5 (true)、Constants.bundleData2(false)；不传的话默认 true
///        Constants.bundleData2: '授权协议',
///      },
///    );
/// ```

class WebViewScreen extends BaseWebViewScreen {
  const WebViewScreen({super.key});

  @override
  State<StatefulWidget> createState() => WebViewScreenState();
}

class WebViewScreenState extends BaseWebViewScreenState {

  @override
  void initState() {
    super.initState();
    getController().startLoad(
      StringUtil.getValueOrDefault(
        Get.arguments[Constants.bundleData],
        'https://www.baidu.com/',
      ),
    );
  }
}
