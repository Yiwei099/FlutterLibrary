import 'package:xiandun/bean/authorize_history_response.dart';
import 'package:xiandun/constants/global_data_manager.dart';
import 'package:xiandun/http/http_util.dart';

class AuthorizeService {
  getAuthorizeHistory({
    required int pageNum,
    required Function(int,AuthorizeHistoryResponse) onSuccess,
  }) {
    HttpUtil.getInstance().post<AuthorizeHistoryResponse>(
      'user/authHistory',
      (onResponse) {
        onSuccess(pageNum,onResponse ?? AuthorizeHistoryResponse());
      },
      () {},
      showLoading: false,
      data: {
        'pageNum': pageNum,
        'pageSize': 10,
        'AnMiId': GlobalDataManager.getInstance().anmiID,
      },
      fromJsonData: AuthorizeHistoryResponse.fromJson,
    );
  }
}
