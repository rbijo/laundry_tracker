/// Wash lifecycle status.
enum WashStatus {
  inProgress,
  completed;

  String toJson() => name;

  static WashStatus fromJson(String? value) {
    if (value == null) return WashStatus.inProgress;
    return WashStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => WashStatus.inProgress,
    );
  }
}
