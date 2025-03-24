import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 通道管理
class ChannelManager {
  //静态属性——该类的实例
  static ChannelManager? _instance;

  static final String _methodInitPFService = 'initPFLogin';
  static final String _methodGetFacetID = 'getFacetID';
  static final String _methodGetAnmiID = 'getAnmiID';
  static final String _methodGetCertificateKey = 'getCertificateKey';
  static final String _methodCreateAuthenticationResponse =
      'createAuthenticationResponse';
  static final String _methodGetRegistrationInformation =
      'getRegistrationInformation';
  static final String _methodStartDetect = 'startDetect';
  static final String _methodPersonVerification = 'personVerification';
  static final String _methodCreateRegistrationResponse =
      'createRegistrationResponse';

  static const MethodChannel _methodChannel = MethodChannel(
    'com.mrdata.xd.channel',
  );

  //私有的命名构造函数，确保类不能从外部被实例化
  ChannelManager._internal();

  static ChannelManager getInstance() {
    _instance ??= ChannelManager._internal();
    return _instance!;
  }

  // 初始化
  void initPFLogin() => _invokeMethod(_methodInitPFService);

  void getFacetID() => _invokeMethodSync(_methodGetFacetID);

  void getAnmiID() => _invokeMethodSync(_methodGetAnmiID);

  //登录
  void createAuthenticationResponse(String param) =>
      _invokeMethod(_methodCreateAuthenticationResponse, param);

  //注册
  void getRegistrationInformation() =>
      _invokeMethod(_methodGetRegistrationInformation);

  //活体检测
  void startDetect() => _invokeMethod(_methodStartDetect);

  //存储数据
  void personVerification(String imgBase64) =>
      _invokeMethod(_methodPersonVerification, imgBase64);

  void createRegistrationResponse(Map<String, String> paramMap) =>
      _invokeMethod(_methodCreateRegistrationResponse, paramMap);

  //获取证书公钥
  void getCertificateKey(Map<String,String> paramMap) =>  _invokeMethod(_methodGetCertificateKey, paramMap);

  void setupMethodCallHandler(Future<dynamic> Function(MethodCall call) call) {
    _methodChannel.setMethodCallHandler(call);
  }

  // 调用原生方法通用处理方法 -- 同步
  Future<T?> _invokeMethodSync<T>(String method, [dynamic arguments]) async {
    try {
      final T? result = await _methodChannel.invokeMethod(method, arguments);
      return result;
    } on PlatformException catch (e) {
      debugPrint(
        "PlatformException 通用处理: ${e.code} - ${e.message} - ${e.details} - ${e.stacktrace}",
      );
      return null;
    } on MissingPluginException catch (e) {
      debugPrint("MissingPluginException 通用处理: ${e.message}");
      return null;
    } on TypeError catch (e) {
      debugPrint("TypeError 通用处理: ${e}");
      return null;
    } catch (e) {
      debugPrint("未知异常 通用处理: $e");
      return null;
    }
  }

  // 调用原生方法通用处理方法 -- 异步(或无需关注结果，或自己异步处理结果)
  Future<T?>? _invokeMethod<T>(String method, [dynamic arguments]) {
    try {
      return _methodChannel.invokeMethod(method, arguments);
    } on PlatformException catch (e) {
      debugPrint(
        "PlatformException 通用处理: ${e.code} - ${e.message} - ${e.details} - ${e.stacktrace}",
      );
      return null;
    } on MissingPluginException catch (e) {
      debugPrint("MissingPluginException 通用处理: ${e.message}");
      return null;
    } on TypeError catch (e) {
      debugPrint("TypeError 通用处理: ${e}");
      return null;
    } catch (e) {
      debugPrint("未知异常 通用处理: $e");
      return null;
    }
  }
}
