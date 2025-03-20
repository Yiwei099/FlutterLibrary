class GlobalDataManager {
  //静态属性——该类的实例
  static GlobalDataManager? _instance;

  //私有的命名构造函数，确保类不能从外部被实例化
  GlobalDataManager._internal();

  static GlobalDataManager getInstance() {
    _instance ??= GlobalDataManager._internal();
    return _instance!;
  }

  String _token = '';

  bool isLogin() {
    return _token.isNotEmpty;
  }
}