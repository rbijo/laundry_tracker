import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_tracker/core/errors/validation_exception.dart';
import 'package:laundry_tracker/domain/models/clothing_category.dart';
import 'package:laundry_tracker/domain/models/clothing_quantities.dart';

void main() {
  group('ClothingCategory Tests', () {
    test('Has exactly nine categories', () {
      expect(ClothingCategory.values.length, 9);
      expect(ClothingCategory.values, [
        ClothingCategory.shirts,
        ClothingCategory.tShirts,
        ClothingCategory.jeans,
        ClothingCategory.trousers,
        ClothingCategory.informalPants,
        ClothingCategory.formalPants,
        ClothingCategory.undergarments,
        ClothingCategory.innerVest,
        ClothingCategory.miscellaneous,
      ]);
    });

    test('JSON serialization and deserialization roundtrip', () {
      for (final category in ClothingCategory.values) {
        final json = category.toJson();
        expect(ClothingCategory.fromJson(json), category);
      }
    });
  });

  group('ClothingQuantities Tests', () {
    test('Default empty initialization has total 0', () {
      final q = ClothingQuantities.empty();
      expect(q.total, 0);
      for (final cat in ClothingCategory.values) {
        expect(q.get(cat), 0);
        expect(q[cat], 0);
      }
    });

    test('Valid quantities 0 through 20 are accepted', () {
      final map = <ClothingCategory, int>{
        ClothingCategory.shirts: 0,
        ClothingCategory.tShirts: 5,
        ClothingCategory.jeans: 20,
      };
      final q = ClothingQuantities(map);
      expect(q[ClothingCategory.shirts], 0);
      expect(q[ClothingCategory.tShirts], 5);
      expect(q[ClothingCategory.jeans], 20);
      expect(q.total, 25);
    });

    test('Throws ValidationException on negative quantities (<0)', () {
      expect(
        () => ClothingQuantities({ClothingCategory.shirts: -1}),
        throwsA(isA<ValidationException>()),
      );
    });

    test('Throws ValidationException on quantities exceeding maximum (>20)', () {
      expect(
        () => ClothingQuantities({ClothingCategory.jeans: 21}),
        throwsA(isA<ValidationException>()),
      );
    });

    test('Total clothes is automatically calculated across all 9 categories', () {
      final map = <ClothingCategory, int>{};
      for (final cat in ClothingCategory.values) {
        map[cat] = 2;
      }
      final q = ClothingQuantities(map);
      expect(q.total, 18);
    });

    test('copyWithCategory updates specific category', () {
      final q1 = ClothingQuantities({ClothingCategory.shirts: 3});
      final q2 = q1.copyWithCategory(ClothingCategory.shirts, 7);
      expect(q1[ClothingCategory.shirts], 3);
      expect(q2[ClothingCategory.shirts], 7);
    });

    test('JSON serialization and deserialization roundtrip', () {
      final original = ClothingQuantities({
        ClothingCategory.shirts: 2,
        ClothingCategory.tShirts: 4,
        ClothingCategory.jeans: 1,
        ClothingCategory.undergarments: 6,
      });

      final json = original.toJson();
      final restored = ClothingQuantities.fromJson(json);

      expect(restored, original);
      expect(restored.total, original.total);
    });
  });
}
