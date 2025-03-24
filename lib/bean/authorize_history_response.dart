import 'package:xiandun/bean/authorize_history_response_item.dart';

class AuthorizeHistoryResponse {
  int total;
  bool hasNextPage;
  List<AuthorizeHistoryResponseItem> retList;

  AuthorizeHistoryResponse({
    this.total = 0,
    this.hasNextPage = false,
    this.retList = const [],
  });

  factory AuthorizeHistoryResponse.fromJson(Map<String, dynamic> json) {
    return AuthorizeHistoryResponse(
      total: json['total'] ?? 0,
      hasNextPage: json['hasNextPage'] ?? false,
      retList: (json['retList'] as List<dynamic>).map((e) => AuthorizeHistoryResponseItem.fromJson(e)).toList(),
    );
  }
}