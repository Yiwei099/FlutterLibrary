class StringUtil {
  //<editor-fold desc="单例的实现"》
  //静态属性——该类的实例
  static StringUtil? _instance;

  //私有的命名构造函数，确保类不能从外部被实例化
  StringUtil._internal();

  static StringUtil getInstance() {
    _instance ??= StringUtil._internal();
    return _instance!;
  }

  //</editor-fold desc="单例的实现"》

  static String maskMiddleCharacters(String input) {
    if (input.length <= 8) {
      return input; // 如果字符串长度小于等于8，直接返回原字符串
    }
    String start = input.substring(0, 4);
    String end = input.substring(input.length - 4);
    String middle = '*' * (input.length - 8);
    return start + middle + end;
  }

  static String getNotNull(String? str) => getValueOrDefault(str, '');

  static String getNoEmpty(String? str,String defaultValue) {
    final result = getValueOrDefault(str, '');
    return result.isEmpty ? defaultValue : result;
  }

  static String getValueOrDefault(String? str, String defaultValue) =>
      str ?? defaultValue;

  static bool isNotNullOrEmpty(String? str) => !isNullOrEmpty(str);
  static bool isNullOrEmpty(String? str) => str == null || str.isEmpty;
}