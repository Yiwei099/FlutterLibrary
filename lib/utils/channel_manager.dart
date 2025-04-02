import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 通道管理
/// 使用方式：
/// 1. 定义通道名称(建议于原生函数一致)： _method + xxx
/// 2. Flutter 调用通道： _invokeMethod('通道名称')
///   2.1 如果该通道需要同步的返回值，直接使用 _invokeMethod 的返回值 Future<T?>
///   2.2 如果该通道需要异步的返回值，使用需要定义的回调函数接收原生的调用
///     2.2.1 定义回调函数：Function(原生传参类型(Map/Json))? callBack;
///     2.2.2 在 setMethodCallHandler 中处理原生异步回调的响应
///     2.2.2.1 对 call.method 进行 case，根据业务进行判断，处理对应的业务；
///             call.method 建议与 Flutter 发起的通道一致，这样定义可以清楚地知道这是一个闭环
class ChannelManager {
  //<editor-fold desc="单例的实现"》
  //静态属性——该类的实例
  static ChannelManager? _instance;

  //私有的命名构造函数，确保类不能从外部被实例化
  ChannelManager._internal();

  static ChannelManager getInstance() {
    _instance ??= ChannelManager._internal();
    return _instance!;
  }

  //</editor-fold desc="单例的实现"》

  // 通道名称
  static const MethodChannel _methodChannel = MethodChannel(
    'com.eiviayw.channel',
  );

  //<editor-fold desc="约定的函数名称">
  //</editor-fold desc="约定的函数名称">

  //<editor-fold desc="业务变量">
  //</editor-fold desc="业务变量">

  void setupMethodCallHandler() {
    _methodChannel.setMethodCallHandler((call) async {
      debugPrint('call.method: ${call.method} - ${call.arguments}');
    });
    init();
  }

  init() {
    _invokeMethod('testPass',{'key': 'message from flutter'})?.then((result){
      debugPrint('testPass callBack from android：$result');
    });
    _invokeMethod('testPassAsynchronous',{'key': 'message from flutter by asynchronous'});
  }

  destroyMethodCallHandler() {
    _methodChannel.setMethodCallHandler(null);
  }

  // 调用原生方法通用处理方法
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
      debugPrint("TypeError 通用处理: $e");
      return null;
    } catch (e) {
      debugPrint("未知异常 通用处理: $e");
      return null;
    }
  }
}
