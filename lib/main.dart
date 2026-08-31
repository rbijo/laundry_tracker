import 'package:flutter/material.dart';
import 'app_shell.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final themeController = ThemeController();
  runApp(LaundryTrackerApp(themeController: themeController));
}

/// Root widget for the Laundry Tracker application.
class LaundryTrackerApp extends StatelessWidget {
  const LaundryTrackerApp({
    super.key,
    required this.themeController,
  });

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeController,
      builder: (context, _) {
        return MaterialApp(
          title: 'Laundry Tracker',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.themeMode,
          home: AppShell(themeController: themeController),
        );
      },
    );
  }
}
