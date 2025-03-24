import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:xiandun/bean/app_info.dart';
import 'package:xiandun/bean/user_info.dart';
import 'package:xiandun/constants/constants.dart';
import 'package:xiandun/constants/global_data_manager.dart';
import 'package:xiandun/http/http_util.dart';

class HomeService {
  //获取最新版本
  getAppVersionInfo() {
    HttpUtil.getInstance()
        .get<AppInfo>(
          'app/app-version/info',
          params: {
            'appName': Constants.appName,
            'appType': 'ANDROID',
            'version': 'init',
          },
          showLoading: false,
          fromJsonData: AppInfo.fromJson,
        )
        .then((value) {
          debugPrint(value?.version ?? '1');
        })
        .catchError((e) {
          debugPrint(e.toString());
        });
  }

  //获取红点数量
  getRedNum({required Function(int) onSuccess, required Function() onError}) {
    HttpUtil.getInstance().postBySimpleResponse<int>(
      'user/redNum',
      onSuccess: (int? count) {
        onSuccess(count ?? 0);
      },
      onError: () {
        onError();
      },
      showLoading: false,
      data: {'keyId': GlobalDataManager.getInstance().getKeyId()},
    );
  }

  faceExpiration() {
    return HttpUtil.getInstance().postSimpleSync(
      'certify/check',
      data: {'userId': GlobalDataManager.getInstance().getUserId()},
    );
  }

  getUserInfo(Function(UserInfo?) onSuccess, Function() onError) {
    HttpUtil.getInstance().post<UserInfo>(
      'user/getUserInfo',
      data: {'keyId': GlobalDataManager.getInstance().getKeyId()},
      onSuccess,
      onError,
      fromJsonData: UserInfo.fromJson,
    );
  }

  modifyUserInfo(
    String nickName,
    String avatar,
    Function(UserInfo?) onSuccess,
    Function() onError,
  ) {
    HttpUtil.getInstance().postByFormData(
      'user/update',
      data: FormData.fromMap({
        'keyId': GlobalDataManager.getInstance().getKeyId(),
        'nickname': nickName,
        'avatar': avatar,
      }),
      onSuccess,
      onError,
      fromJsonData: UserInfo.fromJson,
    );
  }
}
