class AppInfo {
  String id;
  String version;
  String versionCode;
  String versionName;
  String versionInfo;
  int forceUpdate;
  String downloadUrl;
  String type;
  String appName;
  String description;
  int needUpdate;

  AppInfo({
    this.id = '',
    this.version = '',
    this.versionCode = '',
    this.versionName = '',
    this.versionInfo = '',
    this.forceUpdate = 0,
    this.downloadUrl = '',
    this.type = '',
    this.appName = '',
    this.description = '',
    this.needUpdate = 0,
  });

  factory AppInfo.fromJson(Map<String, dynamic> json) {
    return AppInfo(
      id: json['id'],
      version: json['version'],
      versionCode: json['versionCode'],
      versionName: json['versionName'],
      versionInfo: json['versionInfo'],
      forceUpdate: json['forceUpdate'],
      downloadUrl: json['downloadUrl'],
      type: json['type'],
      appName: json['appName'],
      description: json['description'],
      needUpdate: json['needUpdate'],
    );
  }
}