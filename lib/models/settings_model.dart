import 'package:flutter/material.dart';

class SettingsModel extends ChangeNotifier {
  bool isDarkMode = false;
  double fontSize = 14.0;
  String scriptLanguage = 'en';
  bool rememberSettings = false;

  void toggleDarkMode(bool value) {
    isDarkMode = value;
    notifyListeners();
  }

  void setFontSize(double size) {
    fontSize = size;
    notifyListeners();
  }

  void setScriptLanguage(String language) {
    scriptLanguage = language;
    notifyListeners();
  }

  void toggleRememberSettings(bool value) {
    rememberSettings = value;
    notifyListeners();
  }
}
