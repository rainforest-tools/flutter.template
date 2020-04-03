import 'package:flutter/material.dart';

enum SettingsEnum {
  isDarkMode,
  layout
}
enum Layout {
  DEFAULT,
  RESUME
}

class Settings {
  bool isDarkMode = true;
  Layout layout = Layout.DEFAULT;
}

class SettingsNotifier extends ChangeNotifier {
  Settings _settings = Settings();

  Settings get settings => _settings;

  void setSettings(SettingsEnum key, value) {
    switch(key) {
      case SettingsEnum.isDarkMode:
        _settings.isDarkMode = value;
        break;
      case SettingsEnum.layout:
        _settings.layout = value;
        break;
      default:
        break;
    }
    notifyListeners();
  }
}