import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:wanandroid_flutter/http/api.dart';

class HttpClient {
  static const String GET = "GET";
  static const String POST = "POST";
  Dio dio;

  /// 定义私有变量
  static HttpClient _client;

  HttpClient() {
    dio = new Dio();
    dio.options.baseUrl = Api.BASE_URL;
    dio.options.connectTimeout = 5 * 1000;
    dio.options.sendTimeout = 5 * 1000;
    dio.options.receiveTimeout = 5 * 1000;
  }

  static HttpClient getInstance() {
    if (_client == null) {
      _client = new HttpClient();
    }
    return _client;
  }

  ///  GET 请求
  void get(String url, Function callback,
      {Map<String, String> params, Function errorCallback}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer();
      params.forEach((key, value) {
        sb.write("$key=" + "$value" + "&");
      });
      String paramsString = params.toString();
      paramsString = paramsString.substring(0, params.length - 1);
      url += paramsString;
    }
    _request(url, GET, callback, errorCallback: errorCallback);
  }

  /// POST 请求
  void post(url, Function callback,
      {Map<String, String> params, Function errorCallback}) async {
    _request(url, POST, callback, errorCallback: errorCallback);
  }

  /// 私有方法，只可本类访问
  void _request(String url, String method, Function callback,
      {Map<String, String> params, Function errorCallback}) async {
    Response response;
    try {
      if (GET == method) {
        response = await dio.get(url);
      } else if (POST == method) {
        response = await dio.post(url, data: params);
      }
      if (response.statusCode != 200) {
        _handleErrorCallback(errorCallback, "网络连接异常");
        return;
      }
    } on DioError catch (e) {
      // 请求错误
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
    }

    var jsonString = json.encode(response.data);
    print("jsonString = $jsonString");
    // map中的泛型为 dynamic
    Map<String, dynamic> dataMap = json.decode(jsonString);
    print("datamap = $dataMap");
    if (dataMap != null) {
      int errorCode = dataMap['errorCode'];
      String errorMsg;
      errorMsg = dataMap['errorMsg'];
      print("errormsg = $errorMsg");
      if (errorCode != 0) {
        _handleErrorCallback(errorCallback, errorMsg);
        return;
      }
      if (callback != null) {
        callback(response.data);
      }
    } else {
      _handleErrorCallback(errorCallback, "数据解析失败");
    }
  }

  void _handleErrorCallback(Function errorCallback, String errorMsg) {
//    Fluttertoast.showToast(
//        msg: errorMsg,
//        toastLength: Toast.LENGTH_SHORT,
//        gravity: ToastGravity.CENTER);
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
  }
}
