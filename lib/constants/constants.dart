class Constants {

  //静态属性——该类的实例
  static Constants? _instance;

  //私有的命名构造函数，确保类不能从外部被实例化
  Constants._internal();

  static Constants getInstance() {
    _instance ??= Constants._internal();
    return _instance!;
  }

  //后端地址测试环境
  static const String baseUrlDevMR = 'http://218.201.64.200:11080/carsystem-car/';
  //后端地址正式环境
  static const String baseUrlMR = 'http://221.5.140.231:18081/carsystem-car/';
  //注册和免密登录正式环境
  static const String baseUrlLogin = 'http://221.5.140.231:18081/mianmi/';
  //注册和免密登录测试环境
  static const String baseUrlLoginDev = 'http://218.201.64.200:28081/mianmi/';

  //隐私政策
  static const String urlPrivacy = 'http://221.5.140.231:18081/dq-web/privacy/policy';
  //用户协议
  static const String agreement = 'http://221.5.140.231:18081/dq-web/service/protocol';
  static const String noPasswordLoginPolicy = 'http://221.5.140.231:18081/dq-web/password/free/policy';

  // 组件传参 BundleKey
  static const String bundleData = 'bundle_data';
  static const String bundleData1 = 'bundle_data_1';
  static const String bundleData2 = 'bundle_data_2';
  static const String bundleData3 = 'bundle_data_3';

  // 组件结果回传 ReleaseKey
  static const String resultData = 'result_data';
  static const String resultData1 = 'result_data1';
  static const String resultData2 = 'result_data2';
  static const String resultData3 = 'result_data3';

  // sharePreferenceKey
  static const String spFirstInstall = 'first_install';

  // 通道名称
  static const String nativeChannel = 'com.mrdata.xd/native';

  // 方法名称
  static const String getBatteryLevel = 'getBatteryLevel';
  static const String showToast = 'showToast';
  static const String openSettings = 'openSettings';

}