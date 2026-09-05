/// The nine standard clothing categories supported by Laundry Tracker.
enum ClothingCategory {
  shirts('Shirts'),
  tShirts('T Shirts'),
  jeans('Jeans'),
  trousers('Trousers'),
  informalPants('Informal Pants'),
  formalPants('Formal Pants'),
  undergarments('Undergarments'),
  innerVest('Inner Vest'),
  miscellaneous('Miscellaneous');

  final String displayName;

  const ClothingCategory(this.displayName);

  String toJson() => name;

  static ClothingCategory fromJson(String value) {
    return ClothingCategory.values.firstWhere(
      (e) => e.name == value,
      orElse: () => throw ArgumentError('Unknown ClothingCategory: '),
    );
  }
}
