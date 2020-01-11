import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) {
    var path = options.path;
    var parameters = options.queryParameters;
    print("onRequest: path = $path");
    print("onRequest: parameters = $parameters");
    var cookieJar = new PersistCookieJar(dir: "./cookies");
    options.headers.addAll({"developer": "xing", "cookie": cookieJar});
    return super.onRequest(options);
  }
}
