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

// import 'package:flutter/material.dart';
// import 'package:wslc_226_datbase/app_Themes/app_theme.dart';
//
// class ThemeChanger with ChangeNotifier {
//   ThemeData _themeData = lightMode;
//
//   ThemeData get themeData => _themeData;
//
//   set themeData(ThemeData themeMode) {
//     _themeData = themeData;
//     notifyListeners();
//   }
//
//   void toggleTheme() {
//     if (_themeData == lightMode) {
//       themeData = darkMode;
//     } else {
//       themeData = lightMode;
//     }
//   }
// }
