import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_tracker/core/theme/theme_controller.dart';
import 'package:laundry_tracker/main.dart';

void main() {
  group('Phase 1: Application Shell Tests', () {
    late ThemeController themeController;

    setUp(() {
      themeController = ThemeController();
    });

    testWidgets('Renders MaterialApp with Material 3 and initial Home screen', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(LaundryTrackerApp(themeController: themeController));
      await tester.pumpAndSettle();

      // Check App Title on Home
      expect(find.text('Laundry Tracker'), findsOneWidget);

      // Check Greeting on Home
      expect(find.text('Hello Robin!'), findsOneWidget);

      // Check In Progress and Completed sections on Home
      expect(find.text('In Progress'), findsOneWidget);
      expect(find.text('Completed Washes'), findsOneWidget);
      expect(find.text('No active washes'), findsOneWidget);
      expect(find.text('Total Completed'), findsOneWidget);
      expect(find.text('Successfully Tracked'), findsOneWidget);
    });

    testWidgets('Bottom navigation contains exactly four destinations', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(LaundryTrackerApp(themeController: themeController));
      await tester.pumpAndSettle();

      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('New'), findsOneWidget);
      expect(find.text('Track'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('Navigates to New screen shell correctly', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(LaundryTrackerApp(themeController: themeController));
      await tester.pumpAndSettle();

      // Tap on 'New' destination in NavigationBar
      await tester.tap(find.byIcon(Icons.add_circle_outline));
      await tester.pumpAndSettle();

      expect(find.text('New Wash'), findsWidgets);
      expect(find.text('Create a New Wash Batch'), findsOneWidget);
    });

    testWidgets('Navigates to Track screen shell and expands completed section', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(LaundryTrackerApp(themeController: themeController));
      await tester.pumpAndSettle();

      // Tap on 'Track' destination in NavigationBar
      await tester.tap(find.byIcon(Icons.track_changes_outlined));
      await tester.pumpAndSettle();

      expect(find.text('Track Washes'), findsOneWidget);
      expect(find.text('Active Washes'), findsOneWidget);
      expect(find.text('No active washes to track'), findsOneWidget);

      // Verify expandable section
      expect(find.text('Completed Washes'), findsOneWidget);
      await tester.tap(find.text('Completed Washes'));
      await tester.pumpAndSettle();

      expect(find.text('No completed washes yet'), findsOneWidget);
    });

    testWidgets('Navigates to Settings screen shell and verifies functional theme switching', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(LaundryTrackerApp(themeController: themeController));
      await tester.pumpAndSettle();

      // Tap on 'Settings' destination in NavigationBar
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();

      expect(find.text('Appearance'), findsOneWidget);
      expect(find.text('Wash Limits'), findsOneWidget);
      expect(find.text('Issues & Discrepancies'), findsOneWidget);
      expect(find.text('Data Management'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);

      // Check initial Theme is System
      expect(themeController.themeMode, ThemeMode.system);

      // Tap Dark Theme
      await tester.tap(find.text('Dark'));
      await tester.pumpAndSettle();
      expect(themeController.themeMode, ThemeMode.dark);

      // Tap Light Theme
      await tester.tap(find.text('Light'));
      await tester.pumpAndSettle();
      expect(themeController.themeMode, ThemeMode.light);

      // Tap System default
      await tester.tap(find.text('System default'));
      await tester.pumpAndSettle();
      expect(themeController.themeMode, ThemeMode.system);
    });
  });
}
