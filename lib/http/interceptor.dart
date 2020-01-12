import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) {
    var path = options.path;
    var parameters = options.queryParameters;
    print("onRequest: path = $path");
    print("onRequest: parameters = $parameters");
    print("onRequest: options.headers = ${options.headers}");
    options.headers.addAll({"developer": "xing"});
    return super.onRequest(options);
  }
}
