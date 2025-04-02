import 'package:FlutterLibrary/utils/share_perferences_util.dart';
import 'package:get/get.dart';

/// 首页控制器
class HomeController extends GetxController {
  /// 当前显示的页码
  var currentIndex = 0.obs;


  @override
  void onInit() async {
    super.onInit();
    // 初始化 SharedPreferences
    await SharedPreferencesUtil.getInstance().init();
  }

  /// 切换页码
  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
