import 'package:flutter/material.dart';

import '../../../core/theme/theme_controller.dart';
import '../../../core/utils/app_metadata.dart';
import '../../../shared/widgets/section_header.dart';

/// Settings destination shell with functional Theme selection and placeholders for later phases.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.themeController});

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListenableBuilder(
        listenable: themeController,
        builder: (context, _) {
          final currentMode = themeController.themeMode;
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            children: [
              // Theme Selection Section (Functional)
              const SectionHeader(title: 'Appearance', subtitle: 'Customize application theme'),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Radio<ThemeMode>.adaptive(
                          value: ThemeMode.system,
                          // ignore: deprecated_member_use
                          groupValue: currentMode,
                          // ignore: deprecated_member_use
                          onChanged: (mode) {
                            if (mode != null) {
                              themeController.setThemeMode(mode);
                            }
                          },
                        ),
                        title: const Text('System default'),
                        subtitle: const Text('Follow Android device system theme'),
                        onTap: () => themeController.setThemeMode(ThemeMode.system),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: Radio<ThemeMode>.adaptive(
                          value: ThemeMode.light,
                          // ignore: deprecated_member_use
                          groupValue: currentMode,
                          // ignore: deprecated_member_use
                          onChanged: (mode) {
                            if (mode != null) {
                              themeController.setThemeMode(mode);
                            }
                          },
                        ),
                        title: const Text('Light'),
                        onTap: () => themeController.setThemeMode(ThemeMode.light),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: Radio<ThemeMode>.adaptive(
                          value: ThemeMode.dark,
                          // ignore: deprecated_member_use
                          groupValue: currentMode,
                          // ignore: deprecated_member_use
                          onChanged: (mode) {
                            if (mode != null) {
                              themeController.setThemeMode(mode);
                            }
                          },
                        ),
                        title: const Text('Dark'),
                        onTap: () => themeController.setThemeMode(ThemeMode.dark),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Concurrent Wash Limit (Placeholder for later phase)
              const SectionHeader(title: 'Wash Limits', subtitle: 'Configure maximum simultaneous active washes'),
              Card(
                child: ListTile(
                  leading: Icon(Icons.speed, color: theme.colorScheme.primary),
                  title: const Text('Concurrent Wash Limit'),
                  subtitle: const Text('Thermostat radial control (1 - 30)'),
                  trailing: const Chip(label: Text('Phase 4')),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Concurrent wash limit selector will be available in Phase 4.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Issues (Placeholder for later phase)
              const SectionHeader(title: 'Issues & Discrepancies', subtitle: 'View automatically recorded missing cloth items'),
              Card(
                child: ListTile(
                  leading: Icon(Icons.report_problem_outlined, color: theme.colorScheme.error),
                  title: const Text('Recorded Issues'),
                  subtitle: const Text('Review missing clothing records and tracking notes'),
                  trailing: const Chip(label: Text('Phase 5')),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Issue records modal will be available in Phase 5.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Reset Washes (Placeholder with cautionary style)
              const SectionHeader(title: 'Data Management', subtitle: 'Clear all wash records and history'),
              Card(
                child: ListTile(
                  leading: Icon(Icons.delete_forever_outlined, color: theme.colorScheme.error),
                  title: Text('Reset Washes', style: TextStyle(color: theme.colorScheme.error)),
                  subtitle: const Text('Requires confirmation. Deletes active & completed washes.'),
                  trailing: const Chip(label: Text('Phase 5')),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Reset washes action will be available in Phase 5.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // About Section (Reflects AppMetadata.version)
              const SectionHeader(title: 'About', subtitle: 'Application information'),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.local_laundry_service, color: theme.colorScheme.primary),
                      title: const Text('Laundry Tracker'),
                      subtitle: const Text('Version ${AppMetadata.version}'),
                    ),
                    const Divider(height: 1),
                    const ListTile(
                      leading: Icon(Icons.android),
                      title: Text('Target Platform'),
                      subtitle: Text('${AppMetadata.targetPlatform} (Local storage)'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}
