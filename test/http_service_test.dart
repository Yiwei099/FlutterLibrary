import 'package:flutter_test/flutter_test.dart';
import 'package:xiandun/http/services/home_service.dart';

void main () {

  group('HomeService', (){
    test('getVersionInfo', (){
      HomeService().getAppVersionInfo();
    });
  });
}