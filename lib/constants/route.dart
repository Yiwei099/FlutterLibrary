import 'package:FlutterLibrary/feature/home/screen/home_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const String home = '/';

  //静态属性——该类的实例
  static Routes? _instance;

  //私有的命名构造函数，确保类不能从外部被实例化
  Routes._internal();

  static Routes getInstance() {
    _instance ??= Routes._internal();
    return _instance!;
  }


  List<GetPage> pages = [
    GetPage(name: Routes.home, page: () => const HomeScreen()), //主页
  ];
}
