import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_tracker/data/datasources/local_file_storage.dart';
import 'package:laundry_tracker/data/repositories/issue_repository_impl.dart';
import 'package:laundry_tracker/data/repositories/settings_repository_impl.dart';
import 'package:laundry_tracker/data/repositories/wash_repository_impl.dart';
import 'package:laundry_tracker/domain/models/app_theme_mode.dart';
import 'package:laundry_tracker/domain/models/clothing_category.dart';
import 'package:laundry_tracker/domain/models/clothing_quantities.dart';
import 'package:laundry_tracker/domain/models/issue_item.dart';
import 'package:laundry_tracker/domain/models/wash_item.dart';
import 'package:laundry_tracker/domain/models/wash_status.dart';
import 'package:laundry_tracker/state/issue_controller.dart';
import 'package:laundry_tracker/state/settings_controller.dart';
import 'package:laundry_tracker/state/wash_controller.dart';

void main() {
  group('State Controllers Tests', () {
    late Directory tempDir;
    late LocalFileStorage storage;
    late SettingsController settingsController;
    late WashController washController;
    late IssueController issueController;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('laundry_state_test_');
      storage = LocalFileStorage(overrideDirectory: tempDir);
      settingsController = SettingsController(
        repository: SettingsRepositoryImpl(storage: storage),
      );
      washController = WashController(
        repository: WashRepositoryImpl(storage: storage),
      );
      issueController = IssueController(
        repository: IssueRepositoryImpl(storage: storage),
      );
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('SettingsController loads default and updates theme and limit', () async {
      expect(settingsController.isLoaded, false);
      await settingsController.loadSettings();
      expect(settingsController.isLoaded, true);
      expect(settingsController.concurrentWashLimit, 1);
      expect(settingsController.themeMode, AppThemeMode.system);
      expect(settingsController.flutterThemeMode, ThemeMode.system);

      await settingsController.updateThemeMode(AppThemeMode.dark);
      expect(settingsController.themeMode, AppThemeMode.dark);
      expect(settingsController.flutterThemeMode, ThemeMode.dark);

      await settingsController.updateConcurrentWashLimit(10);
      expect(settingsController.concurrentWashLimit, 10);
    });

    test('WashController tracks active and completed washes and enforces canCreateWash limit', () async {
      await washController.loadWashes();
      expect(washController.activeWashCount, 0);
      expect(washController.canCreateWash(1), true);

      // Add 1 active wash
      final wash1 = WashItem(
        id: 'w1',
        washDate: DateTime(2026, 9, 10),
        status: WashStatus.inProgress,
        quantities: ClothingQuantities({ClothingCategory.shirts: 2}),
      );
      await washController.addWash(wash1);

      expect(washController.activeWashCount, 1);
      // With limit = 1 and 1 active wash, cannot create more
      expect(washController.canCreateWash(1), false);
      // With limit = 2, can create more
      expect(washController.canCreateWash(2), true);

      // Complete wash1 with Received All
      final completedWash1 = wash1.copyWith(
        status: WashStatus.completed,
        isSuccessfullyTracked: true,
      );
      await washController.updateWash(completedWash1);

      expect(washController.activeWashCount, 0);
      expect(washController.totalCompletedWashes, 1);
      expect(washController.successfullyTrackedWashes, 1);
      expect(washController.canCreateWash(1), true);
    });

    test('IssueController records and manages issues', () async {
      await issueController.loadIssues();
      expect(issueController.totalIssues, 0);

      final issue = IssueItem(
        id: 'iss-1',
        washId: 'w-1',
        missingQuantities: ClothingQuantities({ClothingCategory.jeans: 1}),
      );
      await issueController.recordIssue(issue);

      expect(issueController.totalIssues, 1);
      expect(issueController.allIssues.first.id, 'iss-1');

      await issueController.removeIssue('iss-1');
      expect(issueController.totalIssues, 0);
    });
  });
}
