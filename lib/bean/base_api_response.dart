class BaseApiResponse<T> {
  final String msg;
  final dynamic code; // 接口不规范，成功是 int = 200；失败是 String = 500
  final T? data;

  BaseApiResponse({required this.msg, required this.code, required this.data});

  factory BaseApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonData,
  ) {
    if (json['data'] == null) {
      return BaseApiResponse(
        msg: json['message'] ?? json['msg'] ?? '',
        code: json['code'],
        data: null,
      );
    }
    return BaseApiResponse(
      msg:  json['message'] ?? json['msg'] ?? '',
      code: json['code'],
      data: fromJsonData(json['data']),
    );
  }

  factory BaseApiResponse.fromJsonSimple(
      Map<String, dynamic> json) {
    if (json['data'] == null) {
      return BaseApiResponse(
        msg: json['message'] ?? json['msg'] ?? '',
        code: json['code'],
        data: null,
      );
    }
    return BaseApiResponse(
      msg:  json['message'] ?? json['msg'] ?? '',
      code: json['code'],
      data: json['data'],
    );
  }
}
