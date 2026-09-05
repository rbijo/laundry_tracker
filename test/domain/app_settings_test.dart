import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_tracker/core/errors/validation_exception.dart';
import 'package:laundry_tracker/domain/models/app_settings.dart';
import 'package:laundry_tracker/domain/models/app_theme_mode.dart';

void main() {
  group('AppSettings Tests', () {
    test('Default settings have limit = 1 and theme = system', () {
      final settings = AppSettings.defaults();
      expect(settings.concurrentWashLimit, 1);
      expect(settings.themeMode, AppThemeMode.system);
      expect(settings.schemaVersion, 1);
    });

    test('Valid limits 1 through 30 are accepted', () {
      final s1 = AppSettings(concurrentWashLimit: 1);
      final s30 = AppSettings(concurrentWashLimit: 30);
      final s15 = AppSettings(concurrentWashLimit: 15);

      expect(s1.concurrentWashLimit, 1);
      expect(s30.concurrentWashLimit, 30);
      expect(s15.concurrentWashLimit, 15);
    });

    test('Throws ValidationException on limit < 1 or limit > 30', () {
      expect(
        () => AppSettings(concurrentWashLimit: 0),
        throwsA(isA<ValidationException>()),
      );
      expect(
        () => AppSettings(concurrentWashLimit: 31),
        throwsA(isA<ValidationException>()),
      );
    });

    test('JSON serialization and deserialization roundtrip', () {
      final original = AppSettings(
        themeMode: AppThemeMode.dark,
        concurrentWashLimit: 7,
      );

      final json = original.toJson();
      final restored = AppSettings.fromJson(json);

      expect(restored, original);
      expect(restored.themeMode, AppThemeMode.dark);
      expect(restored.concurrentWashLimit, 7);
    });
  });
}
