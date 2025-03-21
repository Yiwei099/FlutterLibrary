import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xiandun/bean/base_api_response.dart';
import 'package:xiandun/constants/constants.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  late Dio _dio;

  // 单例模式
  factory HttpUtil() {
    return _instance;
  }

  String _getBaseUrlMR() {
    if(kDebugMode) {
      return Constants.baseUrlDevMR;
    } else {
      return Constants.baseUrlMR;
    }
  }

  String _getBaseUrlLogin() {
    if(kDebugMode) {
      return Constants.baseUrlLoginDev;
    } else {
      return Constants.baseUrlLogin;
    }
  }

  // url 更新为明睿数据
  void updateBaseUrlToMR() {
    _dio.options.baseUrl = _getBaseUrlMR();
  }

  // 初始化
  HttpUtil._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _getBaseUrlLogin(), // API 基础地址
        connectTimeout: const Duration(seconds: 10), // 连接超时时间
        receiveTimeout: const Duration(seconds: 10), // 接收超时时间
      ),
    );

    // 默认请求头
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // 添加拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 请求前的逻辑
          debugPrint('Request: ${options.method} ${options.path}');
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
  Future<BaseApiResponse<T?>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool showLoading = true,
    required T Function(Map<String, dynamic> json) fromJsonData,
  }) async {
    try {
      if (showLoading) _showLoading();

      final response = await _dio.get(path, queryParameters: queryParameters);

      if (showLoading) _hideLoading();

      if (response.statusCode == 200) {
        return BaseApiResponse.fromJson(response.data, fromJsonData);
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (e) {
      if (showLoading) _hideLoading();
      throw Exception('Request failed: ${e.message}');
    }
  }

  // 发起 POST 请求
  Future<T?> post<T>(
    String path, {
    Map<String, dynamic>? data,
    bool showLoading = true,
    required T Function(Map<String, dynamic> json) fromJsonData,
  }) async {
    try {
      if (showLoading) _showLoading();

      final response = await _dio.post(path, data: data);

      if (showLoading) _hideLoading();

      BaseApiResponse<T?> baseApiResponse = BaseApiResponse.fromJson(response.data, fromJsonData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return baseApiResponse.data;
      } else {
        Fluttertoast.showToast(msg: baseApiResponse.msg, toastLength: Toast.LENGTH_SHORT);
        return null;
      }
    } on DioException catch (e) {
      if (showLoading) _hideLoading();
      throw Exception('Request failed: ${e.message}');
    }
  }

  // 其他请求方法（如 PUT、DELETE 等）可以类似实现
}
