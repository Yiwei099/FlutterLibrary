class Constants {

  //静态属性——该类的实例
  static Constants? _instance;

  //私有的命名构造函数，确保类不能从外部被实例化
  Constants._internal();

  static Constants getInstance() {
    _instance ??= Constants._internal();
    return _instance!;
  }

  //隐私政策
  static const String urlPrivacy = 'http://221.5.140.231:18081/dq-web/privacy/policy';
  //用户协议
  static const String agreement = 'http://221.5.140.231:18081/dq-web/service/protocol';

  static const String bundleData = 'bundle_data';
  static const String bundleData1 = 'bundle_data_1';
  static const String bundleData2 = 'bundle_data_2';
  static const String bundleData3 = 'bundle_data_3';
  
  static const String resultData = 'result_data';
  static const String resultData1 = 'result_data1';
  static const String resultData2 = 'result_data2';
  static const String resultData3 = 'result_data3';
}