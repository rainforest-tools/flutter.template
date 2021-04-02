import 'package:flutter/material.dart';

enum SettingsEnum { isDarkMode, layout, socialBarPosition }
enum Layout { DEFAULT, RESUME }
enum SocialBarPosition {
  BOTTOMLEFT,
  BOTTOMCENTER,
  BOTTOMRIGHT,
  CENTERLEFT,
  CENTER,
  CENTERRIGHT,
  TOPLEFT,
  TOPCENTER,
  TOPRIGHT,
  APPBAR
}
SocialBarPosition? mapSocialBarPositionWithAlignment(Alignment alignment) {
  try {
    return SocialBarPosition.values.firstWhere((element) =>
        element.toString().split('.').last.toLowerCase() ==
        alignment.toString().toLowerCase());
  } on StateError {
    return null;
  }
}

class Settings {
  bool isDarkMode = true;
  Layout layout = Layout.DEFAULT;
  SocialBarPosition socialBarPosition = SocialBarPosition.BOTTOMCENTER;
}

class SettingsNotifier extends ChangeNotifier {
  Settings _settings = Settings();

  Settings get settings => _settings;

  void setSettings(SettingsEnum key, value) {
    switch (key) {
      case SettingsEnum.isDarkMode:
        _settings.isDarkMode = value;
        break;
      case SettingsEnum.layout:
        _settings.layout = value;
        break;
      case SettingsEnum.socialBarPosition:
        _settings.socialBarPosition = value;
        break;
      default:
        break;
    }
    notifyListeners();
  }
}
