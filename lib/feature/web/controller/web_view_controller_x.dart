import 'package:get/get.dart';

class WebViewControllerX extends GetxController {
  var progress = 0.obs;

  void updateProgress(int value) {
    progress.value = value;
  }
}