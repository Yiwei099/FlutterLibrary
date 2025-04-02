class Constants {

  //静态属性——该类的实例
  static Constants? _instance;

  //私有的命名构造函数，确保类不能从外部被实例化
  Constants._internal();

  static Constants getInstance() {
    _instance ??= Constants._internal();
    return _instance!;
  }

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
}