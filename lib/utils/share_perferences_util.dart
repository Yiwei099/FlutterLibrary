import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {

//静态属性——该类的实例
  static SharedPreferencesUtil? _instance;

  late SharedPreferences _prefs;

  //私有的命名构造函数，确保类不能从外部被实例化
  SharedPreferencesUtil._internal();

  static SharedPreferencesUtil getInstance() {
    _instance ??= SharedPreferencesUtil._internal();
    return _instance!;
  }

  // 初始化 SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // 异步存储数据
  Future<bool> setString(String key, String value) async {
    return _prefs.setString(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    return _prefs.setInt(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    return _prefs.setDouble(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return _prefs.setBool(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return _prefs.setStringList(key, value);
  }


  // 读取数据
  String getString(String key, {String defaultValue = ''}) {
    return _prefs.getString(key) ?? defaultValue;
  }

  int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  double getDouble(String key, {double defaultValue = 0.0}) {
    return _prefs.getDouble(key) ?? defaultValue;
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  List<String> getStringList(String key, {List<String> defaultValue = const []}) {
    return _prefs.getStringList(key) ?? defaultValue;
  }

  // 删除数据
  Future<bool> remove(String key) async {
    return _prefs.remove(key);
  }

  void removeSync(String key) {
    _prefs.remove(key).then((_) {}).catchError((_) {});
  }

  // 清空所有数据
  Future<bool> clear() async {
    return _prefs.clear();
  }

  void clearSync() {
    _prefs.clear().then((_) {}).catchError((_) {});
  }

  // 检查是否存在某个键
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
}