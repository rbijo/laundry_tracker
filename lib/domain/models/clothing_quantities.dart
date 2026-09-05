import '../../core/constants/app_constants.dart';
import '../../core/errors/validation_exception.dart';
import 'clothing_category.dart';

/// Immutable model holding quantities for all 9 clothing categories.
class ClothingQuantities {
  final Map<ClothingCategory, int> _counts;

  const ClothingQuantities._(this._counts);

  /// Factory constructor ensuring strict 0..20 boundary validation for all categories.
  factory ClothingQuantities([Map<ClothingCategory, int>? counts]) {
    final map = <ClothingCategory, int>{};
    for (final category in ClothingCategory.values) {
      final qty = counts?[category] ?? 0;
      if (qty < AppConstants.minClothingQuantity || qty > AppConstants.maxClothingQuantity) {
        throw ValidationException('Quantity for  must be between  and , got ', field: category.name);
      }
      map[category] = qty;
    }
    return ClothingQuantities._(Map.unmodifiable(map));
  }

  /// Empty quantities (all 0).
  factory ClothingQuantities.empty() => ClothingQuantities();

  /// Gets quantity for a specific category.
  int get(ClothingCategory category) => _counts[category] ?? 0;

  int operator [](ClothingCategory category) => get(category);

  /// Total count automatically derived from all 9 clothing categories.
  int get total => _counts.values.fold(0, (sum, count) => sum + count);

  /// Returns a copy with updated quantity for a category.
  ClothingQuantities copyWithCategory(ClothingCategory category, int quantity) {
    final updated = Map<ClothingCategory, int>.from(_counts);
    updated[category] = quantity;
    return ClothingQuantities(updated);
  }

  /// Returns a copy with batch updates.
  ClothingQuantities copyWith(Map<ClothingCategory, int> updates) {
    final updated = Map<ClothingCategory, int>.from(_counts);
    updated.addAll(updates);
    return ClothingQuantities(updated);
  }

  /// Serializes to `Map<String, int>`.
  Map<String, int> toJson() {
    return _counts.map((k, v) => MapEntry(k.toJson(), v));
  }

  /// Deserializes from `Map<String, dynamic>`.
  factory ClothingQuantities.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ClothingQuantities.empty();
    final map = <ClothingCategory, int>{};
    for (final category in ClothingCategory.values) {
      final val = json[category.name] ?? json[category.toJson()];
      if (val is int) {
        map[category] = val;
      } else if (val is num) {
        map[category] = val.toInt();
      } else {
        map[category] = 0;
      }
    }
    return ClothingQuantities(map);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ClothingQuantities) return false;
    for (final category in ClothingCategory.values) {
      if (get(category) != other.get(category)) return false;
    }
    return true;
  }

  @override
  int get hashCode {
    int hash = 0;
    for (final entry in _counts.entries) {
      hash ^= Object.hash(entry.key, entry.value);
    }
    return hash;
  }

  @override
  String toString() => 'ClothingQuantities(, total: )';
}
