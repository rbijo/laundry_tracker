import 'package:flutter/material.dart';
import 'core/theme/theme_controller.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/new_wash/presentation/new_wash_screen.dart';
import 'features/track/presentation/track_screen.dart';
import 'features/settings/presentation/settings_screen.dart';

/// Root application shell providing 4-destination bottom navigation bar and state preservation.
class AppShell extends StatefulWidget {
  const AppShell({
    super.key,
    required this.themeController,
  });

  final ThemeController themeController;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            onStartNewWash: () => _onDestinationSelected(1),
          ),
          const NewWashScreen(),
          const TrackScreen(),
          SettingsScreen(
            themeController: widget.themeController,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: 'New',
          ),
          NavigationDestination(
            icon: Icon(Icons.track_changes_outlined),
            selectedIcon: Icon(Icons.track_changes),
            label: 'Track',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
