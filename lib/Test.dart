import 'package:dio/dio.dart';

void main() async {
  print("start");
  var result = await request();
  print("result = $result");
}

getData() async {
  Future.delayed(Duration(milliseconds: 10000));
  return "l love android";
}

request() async {
  var dio = new Dio();
  dio.options.connectTimeout = 10 * 1000;
  dio.options.sendTimeout = 10 * 1000;
  dio.options.receiveTimeout = 10 * 1000;
  try {
    Response response = await dio.get("http://www.baidu1.com");
    if (response.statusCode != 200) {
      return response.statusMessage;
    }
    return response.data;
  } catch (e) {
    return e.toString();
  }
}
