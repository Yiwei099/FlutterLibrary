import 'package:FlutterLibrary/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';


/// WebView 控制器
/// 包含功能：
/// 1. 回调 H5 加载进度
/// 2. 根据设定好的标题来源类型获取标题名称
///
class WebViewControllerX extends GetxController {
  late WebViewController _controller;

  /// 加载进度
  final _progress = 0.obs;
  /// 标题
  final _pageTitle = ''.obs;
  /// true - 标题来源于 H5；false - 标题来源于自定义
  bool _titleFromH5 = true;

  isTitleFromH5() => _titleFromH5;
  setTitleFromH5(bool value) {
    _titleFromH5 = value;
  }

  getLoadProgress() => _progress.value;
  getPageTitleValue() => _pageTitle.value;

  @override
  void onInit() {
    super.onInit();
    _initWebViewController();
  }

  /// 初始化WebViewController
  _initWebViewController() {
    _controller = WebViewController();
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // 更新加载进度
            _progress.value = progress;
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) async {
            if (isTitleFromH5()) {
              _pageTitle.value = StringUtil.getNotNull(await _controller.getTitle());
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onHttpError: (HttpResponseError error) {
            debugPrint(
              'Error occurred on page: ${error.response?.statusCode}',
            );
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {
            debugPrint('onHttpAuthRequest ${request.host}');
          },
        ),
      );
  }
  getWebViewController() => _controller;

  /// 加载内容
  startLoad(String url) {
    _controller.loadRequest(Uri.parse(url));
  }

  runJs(String js) {
    _controller.runJavaScript(js);
  }

  /// 返回
  /// 返回 H5 上一页或 关闭页面
  goBack() async{
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return;
    }
    Get.back();
  }
}