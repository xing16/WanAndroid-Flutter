import 'package:flutter/cupertino.dart';

class TextFieldProvider with ChangeNotifier {
  bool _hasFocus = false;
  String _text;

  get hasFocus => _hasFocus;

  get text => _text;

  set setHasFocus(bool focus) {
    _hasFocus = focus;
    notifyListeners();
  }

  set setText(String text) {
    _text = text;
    notifyListeners();
  }

  void switchFocus() {
    _hasFocus = !_hasFocus;
  }
}
