class BaseApiResponse<T> {
  final String msg;
  final int code;
  final T? data;

  BaseApiResponse({required this.msg, required this.code, required this.data});

  factory BaseApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonData,
  ) {
    return BaseApiResponse(
      msg: json['msg'],
      code: json['code'],
      data: fromJsonData(json['data']),
    );
  }
}
