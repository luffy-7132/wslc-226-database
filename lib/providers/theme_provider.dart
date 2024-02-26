import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;

  bool get themeValue {
    return _isDark;
  }

  set themeValue(bool value) {
    _isDark = value;
    notifyListeners();
  }
}
