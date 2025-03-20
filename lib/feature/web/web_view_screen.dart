import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xiandun/constants/constants.dart';
import 'package:xiandun/feature/web/controller/web_view_controller_x.dart';
import 'package:xiandun/widget/com_app_bar.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  late WebViewControllerX _controllerX;
  int progressValue = 0;

  @override
  void initState() {
    super.initState();
    _controllerX = Get.put(WebViewControllerX());

    // 初始化WebViewController
    _initWebViewController();
    _controller.loadRequest(Uri.parse(Get.arguments[Constants.bundleData] ?? 'https://www.baidu.com/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ComAppBar(title: Get.arguments[Constants.bundleData1] ?? ''),
      body: Column(
        children: [
          Obx(() {
            var progress = _controllerX.progress.value;
            return progress < 100
                ? LinearProgressIndicator(
                  value: progress / 100,
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation(Colors.green),
                )
                : const SizedBox();
          }),
          Expanded(child: WebViewWidget(controller: _controller)),
        ],
      ),
    );
  }

  void _initWebViewController() {
    _controller =
        WebViewController()
          // 允许WebView执行JavaScript
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                _controllerX.updateProgress(progress);
              },
              onPageStarted: (String url) {
                debugPrint('Page started loading: $url');
              },
              onPageFinished: (String url) {
                debugPrint('Page finished loading: $url');
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
              onHttpAuthRequest: (HttpAuthRequest request) {},
            ),
          )
          ..addJavaScriptChannel(
            'Toaster',
            onMessageReceived: (JavaScriptMessage message) {
              debugPrint(
                'JavaScript asked us to show a message：${message.message}',
              );
            },
          );
  }
}
