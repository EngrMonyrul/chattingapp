import 'package:chattingapp/themes/dark_mode.dart';
import 'package:chattingapp/themes/light_mode.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeModeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => darkMode == _themeData;

  setThemeMode({required ThemeData themeData}) {
    _themeData = themeData;
    notifyListeners();
  }

  toggleTheme() {
    if (_themeData == lightMode) {
      setThemeMode(themeData: darkMode);
    } else {
      setThemeMode(themeData: lightMode);
    }
    notifyListeners();
  }
}
