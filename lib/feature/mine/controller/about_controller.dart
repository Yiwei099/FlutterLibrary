import 'package:get/get.dart';


class AboutController extends GetxController {
  var version = "".obs;

  ///获取宿主版本号
  void getVersion() {
    version.value = '1.0.0';
  }
}