import 'package:flutter/material.dart';

enum SettingsEnum {
  isDarkMode,
}

class Settings {
  bool isDarkMode = true;
}

class SettingsNotifier extends ChangeNotifier {
  Settings _settings = Settings();

  Settings get settings => _settings;

  void setSettings(SettingsEnum key, value) {
    switch(key) {
      case SettingsEnum.isDarkMode:
        _settings.isDarkMode = value;
        break;
      default:
        break;
    }
    notifyListeners();
  }
}