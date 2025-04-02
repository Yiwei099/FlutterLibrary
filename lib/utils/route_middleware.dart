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

}
