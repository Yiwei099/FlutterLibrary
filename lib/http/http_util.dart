import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xiandun/bean/base_api_response.dart';
import 'package:xiandun/constants/constants.dart';

class HttpUtil {
  //静态属性——该类的实例
  static HttpUtil? _instance;
  late Dio _dio;

  //私有的命名构造函数，确保类不能从外部被实例化
  HttpUtil._internal() {
    _configDio();
  }

  static HttpUtil getInstance() {
    _instance ??= HttpUtil._internal();
    return _instance!;
  }

  // 初始化 Dio
  void _configDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _getBaseUrlMR(), // API 基础地址
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'token': 'GnTi8AVRkgyhrr86ubshywBg695USrXfYP4dcz8eAsg=',
        }, // 请求头
        connectTimeout: const Duration(seconds: 10), // 连接超时时间
        receiveTimeout: const Duration(seconds: 10), // 接收超时时间
      ),
    );

    // 添加拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 请求前的逻辑
          debugPrint('Request: ${options.method} ${options.baseUrl}${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // 响应后的逻辑
          debugPrint('Response: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // 错误处理
          debugPrint('Error: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  // 获取明睿相关 URL
  String _getBaseUrlMR() {
    if (false) {
      return Constants.baseUrlDevMR;
    } else {
      return Constants.baseUrlMR;
    }
  }

  // 获取免密登录相关 URL
  String _getBaseUrlLogin() {
    if (false) {
      return Constants.baseUrlLoginDev;
    } else {
      return Constants.baseUrlLogin;
    }
  }

  // 免密登录后把 URL 更新为明睿数据
  void updateBaseUrlToMR() {
    _dio.options.baseUrl = _getBaseUrlMR();
  }

  // 显示 Loading 弹窗
  void _showLoading() {
    Get.dialog(
      barrierDismissible: false,
      const Center(child: CircularProgressIndicator()),
    );
  }

  // 隐藏 Loading 弹窗
  void _hideLoading() {
    Get.back();
  }

  // 发起 GET 请求
  Future<T?> get<T>(
    String path, {
    Map<String, dynamic>? params,
    bool showLoading = true,
    required T Function(Map<String, dynamic> json) fromJsonData,
  }) async {
    try {
      if (showLoading) _showLoading();
      final response = await _dio.get(path, queryParameters: params);
      if (showLoading) _hideLoading();
      BaseApiResponse<T?> baseApiResponse = BaseApiResponse.fromJson(
        response.data,
        fromJsonData,
      );
      if (response.statusCode == 200) {
        return baseApiResponse.data;
      } else {
        Fluttertoast.showToast(
          msg: '[${baseApiResponse.code}：${baseApiResponse.msg}]',
          toastLength: Toast.LENGTH_SHORT,
        );
        return null;
      }
    } catch (e) {
      if (showLoading) _hideLoading();
      debugPrint(e.toString());
      return null;
    }
  }

  // 发起 POST 请求 -- 同步
  Future<T?> postSync<T>(
    String path, {
    Map<String, dynamic>? data,
    bool showLoading = true,
    required T Function(Map<String, dynamic> json) fromJsonData,
  }) async {
    try {
      if (showLoading) _showLoading();
      final response = await _dio.post(path, data: data);
      if (showLoading) _hideLoading();
      BaseApiResponse<T?> baseApiResponse = BaseApiResponse.fromJson(
        response.data,
        fromJsonData,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return baseApiResponse.data;
      } else {
        Fluttertoast.showToast(
          msg: '[${baseApiResponse.code}：${baseApiResponse.msg}]',
          toastLength: Toast.LENGTH_SHORT,
        );
        return null;
      }
    } catch (e) {
      if (showLoading) _hideLoading();
      debugPrint(e.toString());
      return null;
    }
  }

  // 发起 POST 请求 -- 异步
  void post<T>(
    String path,Function(T?) onSuccess,
      Function() onError,{
    Map<String, dynamic>? data,
    bool showLoading = true,
    required T Function(Map<String, dynamic> json) fromJsonData,
  }) {
    if (showLoading) _showLoading();
    _dio.post(path,data: data).then((onResponse) {
      BaseApiResponse<T?> baseApiResponse = BaseApiResponse.fromJson(
        onResponse.data,
        fromJsonData,
      );
      if (onResponse.statusCode == 200 || onResponse.statusCode == 201) {
        onSuccess(baseApiResponse.data);
      } else {
        Fluttertoast.showToast(
          msg: '[${baseApiResponse.code}：${baseApiResponse.msg}]',
          toastLength: Toast.LENGTH_SHORT,
        );
        onError();
      }
    }).catchError((onError) {
      onError();
    });
  }

  void postBySimpleResponse<T>(
      String path,{
        Map<String, dynamic>? data,
        bool showLoading = true,
        required Function(T?) onSuccess,
        required Function() onError,
      }) {
    if (showLoading) _showLoading();
    _dio.post(path,data: data).then((onResponse) {
      BaseApiResponse<T?> baseApiResponse = BaseApiResponse.fromJsonSimple(
        onResponse.data,
      );
      if (onResponse.statusCode == 200 || onResponse.statusCode == 201) {
        onSuccess(baseApiResponse.data);
      } else {
        Fluttertoast.showToast(
          msg: '[${baseApiResponse.code}：${baseApiResponse.msg}]',
          toastLength: Toast.LENGTH_SHORT,
        );
        onError();
      }
    }).catchError((onError) {
      onError();
    });
  }

  postSimpleSync<T>(
    String path, {
    Map<String, dynamic>? data,
    bool showLoading = true,
  }) async {
    try {
      if (showLoading) _showLoading();
      final response = await _dio.post(path, data: data);
      if (showLoading) _hideLoading();
      BaseApiResponse<T?> baseApiResponse = BaseApiResponse.fromJsonSimple(
        response.data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return baseApiResponse.data;
      } else {
        Fluttertoast.showToast(
          msg: baseApiResponse.msg,
          toastLength: Toast.LENGTH_SHORT,
        );
        return null;
      }
    } catch (e) {
      if (showLoading) _hideLoading();
      debugPrint(e.toString());
      return null;
    }
  }

  postSimple<T>(
    String path, {
    Map<String, dynamic>? data,
    bool showLoading = true,
  }) async {
    try {
      if (showLoading) _showLoading();
      final response = await _dio.post(path, data: data);
      if (showLoading) _hideLoading();
      BaseApiResponse<T?> baseApiResponse = BaseApiResponse.fromJsonSimple(
        response.data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return baseApiResponse.data;
      } else {
        Fluttertoast.showToast(
          msg: baseApiResponse.msg,
          toastLength: Toast.LENGTH_SHORT,
        );
        return null;
      }
    } catch (e) {
      if (showLoading) _hideLoading();
      debugPrint(e.toString());
      return null;
    }
  }
}
