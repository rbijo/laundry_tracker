import '../../core/constants/app_constants.dart';
import '../../core/errors/validation_exception.dart';
import 'app_theme_mode.dart';

/// Application settings domain model.
class AppSettings {
  final AppThemeMode themeMode;
  final int concurrentWashLimit;
  final int schemaVersion;

  AppSettings({
    this.themeMode = AppThemeMode.system,
    this.concurrentWashLimit = AppConstants.defaultConcurrentWashes,
    this.schemaVersion = AppConstants.currentSchemaVersion,
  }) {
    _validateIntegrity();
  }

  void _validateIntegrity() {
    if (concurrentWashLimit < AppConstants.minConcurrentWashes ||
        concurrentWashLimit > AppConstants.maxConcurrentWashes) {
      throw ValidationException(
        'Concurrent wash limit must be between  and , got ',
        field: 'concurrentWashLimit',
      );
    }
  }

  /// Default settings with limit = 1 and theme = system.
  factory AppSettings.defaults() => AppSettings();

  AppSettings copyWith({
    AppThemeMode? themeMode,
    int? concurrentWashLimit,
    int? schemaVersion,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      concurrentWashLimit: concurrentWashLimit ?? this.concurrentWashLimit,
      schemaVersion: schemaVersion ?? this.schemaVersion,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.toJson(),
      'concurrentWashLimit': concurrentWashLimit,
      'schemaVersion': schemaVersion,
    };
  }

  factory AppSettings.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AppSettings.defaults();
    return AppSettings(
      themeMode: AppThemeMode.fromJson(json['themeMode'] as String?),
      concurrentWashLimit: (json['concurrentWashLimit'] as num?)?.toInt() ??
          AppConstants.defaultConcurrentWashes,
      schemaVersion: (json['schemaVersion'] as num?)?.toInt() ??
          AppConstants.currentSchemaVersion,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppSettings) return false;
    return themeMode == other.themeMode &&
        concurrentWashLimit == other.concurrentWashLimit &&
        schemaVersion == other.schemaVersion;
  }

  @override
  int get hashCode => Object.hash(themeMode, concurrentWashLimit, schemaVersion);

  @override
  String toString() =>
      'AppSettings(theme: , limit: , schema: )';
}
