import 'dart:io';
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

void main() {
  group('Repository CRUD Tests', () {
    late Directory tempDir;
    late LocalFileStorage storage;
    late SettingsRepositoryImpl settingsRepo;
    late WashRepositoryImpl washRepo;
    late IssueRepositoryImpl issueRepo;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('laundry_repo_test_');
      storage = LocalFileStorage(overrideDirectory: tempDir);
      settingsRepo = SettingsRepositoryImpl(storage: storage);
      washRepo = WashRepositoryImpl(storage: storage);
      issueRepo = IssueRepositoryImpl(storage: storage);
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('SettingsRepository returns default and saves/retrieves settings', () async {
      final initial = await settingsRepo.getSettings();
      expect(initial.concurrentWashLimit, 1);
      expect(initial.themeMode, AppThemeMode.system);

      final updated = initial.copyWith(
        themeMode: AppThemeMode.light,
        concurrentWashLimit: 8,
      );
      await settingsRepo.saveSettings(updated);

      final retrieved = await settingsRepo.getSettings();
      expect(retrieved.themeMode, AppThemeMode.light);
      expect(retrieved.concurrentWashLimit, 8);
    });

    test('WashRepository handles CRUD, filtering active vs completed, and clearAll', () async {
      expect(await washRepo.getAllWashes(), isEmpty);

      final wash1 = WashItem(
        id: 'wash-1',
        washDate: DateTime(2026, 9, 10),
        status: WashStatus.inProgress,
        quantities: ClothingQuantities({ClothingCategory.shirts: 2}),
      );
      final wash2 = WashItem(
        id: 'wash-2',
        washDate: DateTime(2026, 9, 11),
        status: WashStatus.completed,
        isSuccessfullyTracked: true,
        quantities: ClothingQuantities({ClothingCategory.jeans: 1}),
      );

      await washRepo.saveWash(wash1);
      await washRepo.saveWash(wash2);

      final all = await washRepo.getAllWashes();
      expect(all.length, 2);

      final active = await washRepo.getActiveWashes();
      expect(active.length, 1);
      expect(active.first.id, 'wash-1');

      final completed = await washRepo.getCompletedWashes();
      expect(completed.length, 1);
      expect(completed.first.id, 'wash-2');

      final single = await washRepo.getWashById('wash-1');
      expect(single?.quantities[ClothingCategory.shirts], 2);

      // Update wash
      final updatedWash1 = wash1.copyWith(
        status: WashStatus.completed,
        isSuccessfullyTracked: true,
      );
      await washRepo.saveWash(updatedWash1);
      expect((await washRepo.getWashById('wash-1'))?.status, WashStatus.completed);

      // Delete wash
      await washRepo.deleteWash('wash-2');
      expect(await washRepo.getWashById('wash-2'), isNull);

      // Clear all
      await washRepo.clearAllWashes();
      expect(await washRepo.getAllWashes(), isEmpty);
    });

    test('IssueRepository handles CRUD, filtering by washId, and clearAll', () async {
      expect(await issueRepo.getAllIssues(), isEmpty);

      final issue1 = IssueItem(
        id: 'issue-1',
        washId: 'wash-1',
        missingQuantities: ClothingQuantities({ClothingCategory.shirts: 1}),
      );
      final issue2 = IssueItem(
        id: 'issue-2',
        washId: 'wash-2',
        missingQuantities: ClothingQuantities({ClothingCategory.jeans: 2}),
      );

      await issueRepo.saveIssue(issue1);
      await issueRepo.saveIssue(issue2);

      final all = await issueRepo.getAllIssues();
      expect(all.length, 2);

      final wash1Issues = await issueRepo.getIssuesForWash('wash-1');
      expect(wash1Issues.length, 1);
      expect(wash1Issues.first.id, 'issue-1');

      await issueRepo.deleteIssue('issue-1');
      expect(await issueRepo.getAllIssues(), hasLength(1));

      await issueRepo.clearAllIssues();
      expect(await issueRepo.getAllIssues(), isEmpty);
    });
  });
}
