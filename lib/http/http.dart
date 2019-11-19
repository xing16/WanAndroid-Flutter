import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanandroid_flutter/http/api.dart';

class HttpClient {
  static const String GET = "GET";
  static const String POST = "POST";
  Dio dio;

  /// 私有构造函数
  HttpClient._internal() {
    dio = new Dio();
    dio.options.baseUrl = Api.BASE_URL;
    dio.options.connectTimeout = 10 * 1000;
    dio.options.sendTimeout = 10 * 1000;
    dio.options.receiveTimeout = 10 * 1000;
  }

  /// 保存单例对象
  static HttpClient _client = new HttpClient._internal();

  factory HttpClient() => _client;

  static HttpClient getInstance() {
    return _client;
  }

  ///  GET 请求
  void get(String path,
      {Map<String, dynamic> data,
      Function callback,
      Function errorCallback}) async {
    _request(path, GET, callback, data: data, errorCallback: errorCallback);
  }

  /// POST 请求
  void post(String path,
      {Map<String, String> data,
      Function callback,
      Function errorCallback}) async {
    _request(path, POST, callback, data: data, errorCallback: errorCallback);
  }

  /// 私有方法，只可本类访问
  void _request(String path, String method, Function callback,
      {Map<String, dynamic> data, Function errorCallback}) async {
    data = data ?? {};
    method = method ?? GET;
    data.forEach((key, value) {
      if (path.indexOf(key) != -1) {
        path = path.replaceAll(":$key", value.toString());
      }
    });
    print("url = ${Api.BASE_URL + path}");
    try {
      Response response =
          await dio.request(path, data: data, options: Options(method: method));
      if (response?.statusCode != 200) {
        _handleErrorCallback(errorCallback, "网络连接异常");
        return;
      }
      var jsonString = json.encode(response.data);
      // map中的泛型为 dynamic
      Map<String, dynamic> dataMap = json.decode(jsonString);
      if (dataMap != null) {
        int errorCode = dataMap['errorCode'];
        print("errorcode = $errorCode");
        String errorMsg = dataMap['errorMsg'];
        bool error = dataMap['error'] ?? true;
        var results = dataMap['results'];
        var data = dataMap['data'];
        // 请求失败
        if (errorCode != 0 && error) {
          _handleErrorCallback(errorCallback, errorMsg);
          return;
        }
        if (callback != null) {
          if (data != null) {
            callback(data);
          } else if (results != null) {
            callback(results);
          }
        }
      } else {
        _handleErrorCallback(errorCallback, "数据解析失败");
      }
    } on DioError catch (e) {
      // 请求错误
      var message = e.message;
      print("message = $message");
      _handleErrorCallback(errorCallback, message);
    }
  }

  void _handleErrorCallback(Function errorCallback, String errorMsg) {
    print("_handleErrorCallback = $errorMsg");
    Fluttertoast.showToast(
        msg: errorMsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
  }
}
