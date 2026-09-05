import 'package:flutter/material.dart';

import '../domain/models/app_settings.dart';
import '../domain/models/app_theme_mode.dart';
import '../domain/repositories/i_settings_repository.dart';

/// State controller managing application settings and persistence.
class SettingsController extends ChangeNotifier {
  final ISettingsRepository _repository;
  AppSettings _settings = AppSettings.defaults();
  bool _isLoaded = false;

  SettingsController({required this._repository});

  AppSettings get settings => _settings;
  bool get isLoaded => _isLoaded;
  AppThemeMode get themeMode => _settings.themeMode;
  int get concurrentWashLimit => _settings.concurrentWashLimit;

  /// Translates domain AppThemeMode to Flutter ThemeMode for MaterialApp.
  ThemeMode get flutterThemeMode {
    switch (_settings.themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  Future<void> loadSettings() async {
    _settings = await _repository.getSettings();
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> updateThemeMode(AppThemeMode mode) async {
    if (_settings.themeMode == mode) return;
    _settings = _settings.copyWith(themeMode: mode);
    notifyListeners();
    await _repository.saveSettings(_settings);
  }

  Future<void> updateConcurrentWashLimit(int limit) async {
    if (_settings.concurrentWashLimit == limit) return;
    _settings = _settings.copyWith(concurrentWashLimit: limit);
    notifyListeners();
    await _repository.saveSettings(_settings);
  }
}
