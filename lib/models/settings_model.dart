import 'package:flutter/material.dart';
import 'package:settings_and_preferences/services/settings_store.dart';

class SettingsModel extends ChangeNotifier {
  final SettingsStore _store;
  bool isDarkMode = false;
  double fontSize = 14.0;
  String scriptLanguage = 'en';
  bool rememberSettings = false;

  SettingsModel(this._store);

  //------------------------------------------------------------------------------
  Future<void> loadSettings() async {
    final loadedSettings = await _store.loadSettings();
    if (loadedSettings != null) {
      isDarkMode = loadedSettings['isDarkMode'] == 'true';
      fontSize = double.tryParse(loadedSettings['fontSize']) ?? 14.0;
      scriptLanguage = loadedSettings['scriptLanguage'] ?? 'en';
      rememberSettings = loadedSettings['rememberSettings'] == 'true';
      notifyListeners();
    }
  }

  //------------------------------------------------------------------------------
  void toggleDarkMode(bool value) {
    isDarkMode = value;
    if (rememberSettings) {
      _store.saveSettings(this);
    }
    notifyListeners();
  }

  //------------------------------------------------------------------------------
  void setFontSize(double size) {
    fontSize = size;
    if (rememberSettings) {
      _store.saveSettings(this);
    }
    notifyListeners();
  }

  //------------------------------------------------------------------------------
  void setScriptLanguage(String language) {
    scriptLanguage = language;
    if (rememberSettings) {
      _store.saveSettings(this);
    }
    notifyListeners();
  }

  //------------------------------------------------------------------------------
  void toggleRememberSettings(bool value) {
    rememberSettings = value;
    if (rememberSettings) {
      _store.saveSettings(this);
    }
    notifyListeners();
  }
}
