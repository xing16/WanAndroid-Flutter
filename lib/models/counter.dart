import 'package:flutter/cupertino.dart';

class Counter with ChangeNotifier {
  int _count = 0;

  addCount() {
    _count++;
    notifyListeners();
  }

  subCount() {
    _count--;
    notifyListeners();
  }

  get count => _count;
}
