import '../../core/constants/app_constants.dart';
import '../../domain/models/app_settings.dart';
import '../../domain/repositories/i_settings_repository.dart';
import '../datasources/local_file_storage.dart';

/// Implementation of ISettingsRepository using local JSON file persistence.
class SettingsRepositoryImpl implements ISettingsRepository {
  final ILocalStorageDataSource _storage;

  SettingsRepositoryImpl({ILocalStorageDataSource? storage})
      : _storage = storage ?? LocalFileStorage();

  @override
  Future<AppSettings> getSettings() async {
    final map = await _storage.readJsonObject(AppConstants.settingsFileName);
    if (map == null) {
      final defaults = AppSettings.defaults();
      await saveSettings(defaults);
      return defaults;
    }
    return AppSettings.fromJson(map);
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    await _storage.writeJsonObject(
      AppConstants.settingsFileName,
      settings.toJson(),
    );
  }
}
