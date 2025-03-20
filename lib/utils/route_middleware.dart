import 'package:get/get.dart';
import 'package:xiandun/constants/global_data_manager.dart';
import 'package:xiandun/widget/dialog/secondary_confirmation_dialog.dart';

// class RouteMiddleWare extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) {
//     if (GlobalDataManager.getInstance().isLogin()) {
//       return null;
//     } else {
//       Get.dialog(
//         barrierDismissible:false,
//         SecondaryConfirmationDialog(
//           title: '提醒',
//           content: '是否退出登录',
//           onConfirm: () {},
//         ),
//       );
//       return null;
//     }
//   }
// }

///路由中间件(由于上述使用 GetMiddleware 无法实现需求，所以这里手动封装一个)
class RouteMiddleWare {
  //静态属性——该类的实例
  static RouteMiddleWare? _instance;

  //私有的命名构造函数，确保类不能从外部被实例化
  RouteMiddleWare._internal();

  static RouteMiddleWare getInstance() {
    _instance ??= RouteMiddleWare._internal();
    return _instance!;
  }

  void redirect({bool condition = true, required String name, dynamic args, required Function() donT}) {
    if (condition) {
      //条件符合就跳转
      Get.toNamed(name, arguments: args);
    } else {
      //否则
      donT();
    }
  }

  //跳转前判断是否已经登录
  void redirectAfterLogin({required String name, dynamic args}) {
    if (GlobalDataManager.getInstance().isLogin()) {
      Get.toNamed(name, arguments: args);
    } else {
      Get.dialog(
        barrierDismissible: false,
        SecondaryConfirmationDialog(
          title: '提示',
          content: '即将通过指纹完成登录操作，请确保身份和信息完整',
          onConfirm: () {},
        ),
      );
    }
  }

  void doAfterLogin({required Function() pass}) {
    if (GlobalDataManager.getInstance().isLogin()) {
      pass();
    } else {
      Get.dialog(
        barrierDismissible: false,
        SecondaryConfirmationDialog(
          title: '提示',
          content: '即将通过指纹完成登录操作，请确保身份和信息完整',
          onConfirm: () {
            Get.back();
            pass();
          },
        ),
      );
    }
  }
}
