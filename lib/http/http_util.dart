import 'package:FlutterLibrary/bean/base_api_response.dart';
import 'package:FlutterLibrary/constants/global_data_manager.dart';
import 'package:FlutterLibrary/widget/dialog/loading_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';

/// 网络请求工具类
/// 1. 通用的请求头：包含 Content-Type、token，允许手动更新 token
/// 2. 拦截器：允许在请求发出前再处理 baseUrl、Header 等参数
/// 3. 默认连接和超时时间：10s
/// 4. 通用的 GET、POST 请求
/// 5. 允许单个请求控制 loading 显示
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

  /// 初始化 Dio
  void _configDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _getBaseUrl(), // API 基础地址
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'token': GlobalDataManager.getInstance().getToken(),
        }, // 请求头
        connectTimeout: const Duration(seconds: 10), // 连接超时时间
        receiveTimeout: const Duration(seconds: 10), // 接收超时时间
      ),
    );

    // 添加拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint(
            'Request: ${options.method} ${options.baseUrl}${options.path} data：${options.data}',
          );
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

  /// 获取明睿相关 URL
  String _getBaseUrl() {
    if (false) {
      return 'debugUrl';
    } else {
      return 'releaseUrl';
    }
  }


  /// 更新 Token
  void updateToken(String token) {
    _dio.options.headers['token'] = token;
  }

  /// 显示 Loading 弹窗
  void _showLoading() {
    Future.delayed(Duration.zero, () {
      if (Get.isDialogOpen == false) {
        // 确保没有其他对话框打开
        Get.dialog(
          barrierDismissible: false,
          const LoadingDialog(),
        );
      }
    });
  }

  /// 隐藏 Loading 弹窗
  void _hideLoading() {
    if (Get.isDialogOpen == true) {
      // 确保有对话框打开
      Get.back();
    }
  }

  /// 发起 GET 请求
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

  /// 发起 POST 请求
  /// [path] 请求路径
  /// [data] 请求体
  /// [showLoading] true - 显示 loading；false - 不显示 loading
  /// [fromJsonData] 响应体 data 解析的模板，如果为 null，则不解析 data ，具体看 [BaseApiResponse.fromJsonSimple]
  Future<T?> post<T>({
    required String path,
    required dynamic data,
    bool showLoading = true,
    T Function(Map<String, dynamic> json)? fromJsonData,
  }) async {
    try {
      // 显示 loading
      if (showLoading) _showLoading();
      final response = await _dio.post(path, data: data);
      if (showLoading) _hideLoading();
      BaseApiResponse<T?> baseApiResponse =
          fromJsonData != null
              ? BaseApiResponse.fromJson(response.data, fromJsonData)
              : BaseApiResponse.fromJsonSimple(response.data);
      if (baseApiResponse.code == 200 || baseApiResponse.code == 201) {
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

  postSimpleSyncCompleteResponse<T>({
    required String path,
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
      return baseApiResponse;
    } catch (e) {
      if (showLoading) _hideLoading();
      debugPrint(e.toString());
      return null;
    }
  }
}
