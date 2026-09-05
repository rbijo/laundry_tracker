# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## v.0.3.0

### Added
- Complete domain models for Washes (WashItem), Clothing Categories (ClothingCategory), Quantities (ClothingQuantities), Discrepancy Issues (IssueItem), and Settings (AppSettings, AppThemeMode).
- Domain validation rules enforcing clothing limits (0–20 per category), automatic total clothing calculations, wash dates (cannot be in the past on creation; expected retrieve date must be on or after wash date), and concurrent wash limits (1–30, default 1).
- Local JSON file storage layer (LocalFileStorage) using atomic file operations.
- Local repository implementations (WashRepositoryImpl, IssueRepositoryImpl, SettingsRepositoryImpl) for persisting washes.json, issues.json, and settings.json.
- State controllers (WashController, IssueController, SettingsController) using Flutter's built-in ChangeNotifier and ListenableBuilder architecture.
- Full unit test suite covering models, validation rules, repositories, and state controllers using temporary file directories.

## v.0.2.0

### Added
- Material 3 application shell with responsive Android phone navigation.
- Bottom NavigationBar featuring four destinations: Home, New, Track, and Settings.
- State preservation across tabs using IndexedStack.
- Functional appearance theming supporting System, Light, and Dark modes via ThemeController.
- Home screen with personalized greeting ("Hello Robin!"), active in-progress wash section, and completed wash metrics card.
- New Wash destination entry point with clothing category preview.
- Track screen with active wash monitoring and expandable completed wash history section.
- Settings screen with appearance options, about section, and placeholders for wash limits, issue tracking, and data resets.
- Automated widget testing suite for navigation, shell UI, and theme switching.

## v.0.1.0

### Added
- Initial project foundation and directory structure for Flutter on Android.
- Core project configuration and agent instructions (AGENTS.md).
