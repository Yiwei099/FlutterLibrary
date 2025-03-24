class AuthorizeHistoryResponseItem {
  String name;
  String vin;
  String authTime;
  String endTime;
  String status;
  int rightStatus;
  String oneId;
  String authentication;
  String rightTime;
  bool red;
  String orderType;
  String confirmId;

  AuthorizeHistoryResponseItem({
    this.name = '',
    this.vin = '',
    this.authTime = '',
    this.endTime = '',
    this.status = '',
    this.rightStatus = 0,
    this.oneId = '',
    this.authentication = '',
    this.rightTime = '',
    this.orderType = '',
    this.confirmId = '',
    this.red = false,
  });

  factory AuthorizeHistoryResponseItem.fromJson(Map<String, dynamic> json) {
    return AuthorizeHistoryResponseItem(
      name: json['name'],
      vin: json['vin'],
      authTime: json['authTime'],
      endTime: json['endTime'],
      status: json['status'],
      rightStatus: json['rightStatus'],
      oneId: json['oneId'],
      authentication: json['authentication'],
      rightTime: json['rightTime'],
      orderType: json['orderType'],
    );
  }

  String convertStatusName() {
    switch (status) {
      case STATUS_AUTHORIZED:
        return '已授权';
      case STATUS_REVOEKE:
        return '取消授权';
      case STATUS_REFUSE:
        return '拒绝授权';
      case STATUS_EXPIRES:
        return '授权过期';
      default:
        return '';
    }
  }

  //已授权
  static const String STATUS_AUTHORIZED = '1';
  //取消授权
  static const String STATUS_REVOEKE = '-1';
  //拒绝授权
  static const String STATUS_REFUSE = '-3';
  //授权过期
  static const String STATUS_EXPIRES = '-2';
}