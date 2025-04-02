import 'package:FlutterLibrary/constants/constants.dart';
import 'package:FlutterLibrary/feature/web/controller/web_view_controller_x.dart';
import 'package:FlutterLibrary/utils/icon_path.dart';
import 'package:FlutterLibrary/utils/string_util.dart';
import 'package:FlutterLibrary/widget/com_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// WebView 基类
/// 提供功能：1. 基础控制器 2. 加载进度条 3. JS 交互 4. 获取标题名称、来源
/// 已定义参数：Constants.bundleData = 链接地址；Constants.bundleData1 = true - 标题来源于 H5；false - 标题来源于 Constants.bundleData2；Constants.bundleData2 = 自定义标题
/// 使用方式：请参考 WebViewScreen、AuthorizeWebViewScreen
abstract class BaseWebViewScreen extends StatefulWidget{
  const BaseWebViewScreen({super.key});
}

class BaseWebViewScreenState extends State<BaseWebViewScreen> {
  late WebViewControllerX _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(WebViewControllerX());
    _controller.setTitleFromH5(Get.arguments[Constants.bundleData1] ?? true);
    supplementController(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    Get.delete<WebViewControllerX>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Obx(() {
            var progress = _controller.getLoadProgress();
            return progress < 100
                ? LinearProgressIndicator(
                  value: progress / 100,
                  backgroundColor: Colors.white,
                  valueColor: const AlwaysStoppedAnimation(Colors.green),
                )
                : const SizedBox();
          }),
          Expanded(
            child: WebViewWidget(
              controller: _controller.getWebViewController(),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建页面导航栏
  PreferredSizeWidget _buildAppBar() {
    if (_controller.isTitleFromH5()) {
      // 标题来源于 H5
      return _buildAppBarFormH5();
    }

    return ComAppBar(
      title: StringUtil.getNotNull(
        Get.arguments[Constants.bundleData2],
      ),
      onPressed: () => _controller.goBack(),
    );
  }

  ///  构建标题名称来源于 Url 的 AppBar
  PreferredSizeWidget _buildAppBarFormH5() {
    return AppBar(
      backgroundColor: const Color(0xFF1D51D2),
      title: Obx(() {
        return Text(
          _controller.getPageTitleValue(),
          style: TextStyle(color: Colors.white, fontSize: 10.sp),
        );
      }),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => _controller.goBack(),
        icon: Image.asset(IconPath.back, width: 15, height: 15),
      ),
    );
  }

  /// 不建议追加不通用的功能，如果需要，建议在子类中创建新的 Controller
  WebViewControllerX getController() => _controller;

  /// 开放提供子类补充 WebViewControllerX 相关功能
  /// 不建议追加不通用的功能，如果需要，建议在子类中创建新的 Controller
  void supplementController(WebViewControllerX c) {
    supplementJSChannel(c.getWebViewController());
  }

  /// 开放提供子类补充 JS 交互相关功能
  void supplementJSChannel(WebViewController c) {
  }
}
