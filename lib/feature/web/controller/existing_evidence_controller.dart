import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExistingEvidenceController extends GetxController {
  late WebViewController _controller;

  var progress = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // 初始化WebViewController
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                // 更新加载进度
                updateProgress(progress);
              },
              onPageStarted: (String url) {
                debugPrint('Page started loading: $url');
              },
              onPageFinished: (String url) {},
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

  void updateProgress(int value) {
    progress.value = value;
  }

  getWebViewController() => _controller;
}
