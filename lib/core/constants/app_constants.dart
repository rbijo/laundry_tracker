/// Application-wide constants and boundary limits for Laundry Tracker.
class AppConstants {
  const AppConstants._();

  // Wash & Clothing Limits
  static const int minConcurrentWashes = 1;
  static const int maxConcurrentWashes = 30;
  static const int defaultConcurrentWashes = 1;

  static const int minClothingQuantity = 0;
  static const int maxClothingQuantity = 20;

  // Schema & Storage
  static const int currentSchemaVersion = 1;
  static const String settingsFileName = 'settings.json';
  static const String washesFileName = 'washes.json';
  static const String issuesFileName = 'issues.json';
}
