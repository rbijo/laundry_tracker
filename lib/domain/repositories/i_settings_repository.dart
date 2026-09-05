import '../models/app_settings.dart';

/// Contract for Settings repository data operations.
abstract class ISettingsRepository {
  Future<AppSettings> getSettings();
  Future<void> saveSettings(AppSettings settings);
}
