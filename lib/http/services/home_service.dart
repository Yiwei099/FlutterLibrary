import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:xiandun/bean/app_info.dart';
import 'package:xiandun/constants/constants.dart';
import 'package:xiandun/constants/global_data_manager.dart';
import 'package:xiandun/http/http_util.dart';

class HomeService {
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

  getRedNum() => HttpUtil.getInstance().postSimpleSync(
    'user/redNum',
    showLoading: false,
    data: {'keyId': GlobalDataManager.getInstance().getKeyId()},
  );
}
