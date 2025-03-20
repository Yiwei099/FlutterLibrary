import 'package:get/get.dart';
import 'package:xiandun/feature/authorize/screen/authorize_detail_screen.dart';
import 'package:xiandun/feature/home/screen/home_screen.dart';
import 'package:xiandun/feature/mine/screen/about_screen.dart';
import 'package:xiandun/feature/mine/screen/modify_profile_screen.dart';
import 'package:xiandun/feature/mine/screen/my_certificate_screen.dart';
import 'package:xiandun/feature/mine/screen/profile_screen.dart';
import 'package:xiandun/feature/mine/screen/setting_screen.dart';
import 'package:xiandun/feature/web/web_view_screen.dart';

import '../feature/authorize/screen/scanner_screen.dart';

class Routes {
  static const String home = '/';
  static const String authorizeDetail = '/authorizeDetailScreen';
  static const String setting = '/SettingScreen';
  static const String profile = '/ProfileScreen';
  static const String modifyProfile = '/ModifyProfileScreen';
  static const String myCertificate = '/MyCertificateScreen';
  static const String about = '/AboutScreen';
  static const String webView = '/WebViewScreen';
  static const String scan = '/ScannerScreen';

  //静态属性——该类的实例
  static Routes? _instance;

  //私有的命名构造函数，确保类不能从外部被实例化
  Routes._internal();

  static Routes getInstance() {
    _instance ??= Routes._internal();
    return _instance!;
  }


  List<GetPage> PAGES = [
    GetPage(name: Routes.home, page: () => const HomeScreen()),
    GetPage(name: Routes.authorizeDetail, page: () => const AuthorizeDetailScreen()),
    GetPage(name: Routes.setting, page: () => const SettingScreen()),
    GetPage(name: Routes.profile, page: () => const ProfileScreen()),
    GetPage(name: Routes.modifyProfile, page: () => const ModifyProfileScreen()),
    GetPage(name: Routes.myCertificate, page: () => const MyCertificateScreen()),
    GetPage(name: Routes.about, page: () => const AboutScreen()),
    GetPage(name: Routes.webView, page: () => const WebViewScreen()),
    GetPage(name: Routes.scan, page: () => const ScannerScreen()),
  ];
}
