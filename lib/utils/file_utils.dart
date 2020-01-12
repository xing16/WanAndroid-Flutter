import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// 获取本地缓存路径
Future<String> getCachePath() async {
  var tempDir = await getTemporaryDirectory();
  return tempDir.path;
}

/// 获取 cookie 缓存路径
Future<String> getCookiePath() async {
  String cachePath = await getCachePath();
  return "$cachePath/cookie";
}

Future<bool> isCookieExist() async {
  String cookiePath = await getCookiePath();
  print("cookiePaht = $cookiePath");
  Directory dir = new Directory(cookiePath);
  if (dir != null) {
    List<FileSystemEntity> list = dir.listSync();
    print("list.size = ${list.length}");
    return list != null && list.length > 0;
  }
  return false;
}
