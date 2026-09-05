import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_tracker/core/errors/validation_exception.dart';
import 'package:laundry_tracker/domain/models/clothing_category.dart';
import 'package:laundry_tracker/domain/models/clothing_quantities.dart';
import 'package:laundry_tracker/domain/models/wash_item.dart';
import 'package:laundry_tracker/domain/models/wash_status.dart';

void main() {
  group('WashItem Tests', () {
    final baseDate = DateTime(2026, 9, 10);

    test('Creates wash item with valid data and default values', () {
      final wash = WashItem(
        id: 'wash-1',
        washDate: baseDate,
        expectedRetrieveDate: DateTime(2026, 9, 12),
        quantities: ClothingQuantities({
          ClothingCategory.shirts: 3,
          ClothingCategory.jeans: 2,
        }),
      );

      expect(wash.id, 'wash-1');
      expect(wash.status, WashStatus.inProgress);
      expect(wash.isInProgress, true);
      expect(wash.isCompleted, false);
      expect(wash.isSuccessfullyTracked, false);
      expect(wash.totalClothes, 5);
    });

    test('Throws ValidationException if Wash ID is empty', () {
      expect(
        () => WashItem(id: '', washDate: baseDate),
        throwsA(isA<ValidationException>()),
      );
    });

    test('Throws ValidationException if Expected Retrieve Date is earlier than Wash Date', () {
      expect(
        () => WashItem(
          id: 'wash-1',
          washDate: DateTime(2026, 9, 15),
          expectedRetrieveDate: DateTime(2026, 9, 14),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('Same-day Expected Retrieve Date is valid', () {
      final wash = WashItem(
        id: 'wash-1',
        washDate: DateTime(2026, 9, 15, 10, 0),
        expectedRetrieveDate: DateTime(2026, 9, 15, 18, 0),
      );
      expect(wash.expectedRetrieveDate, isNotNull);
    });

    test('validateNewWashCreation throws if washDate is in the past', () {
      final today = DateTime(2026, 9, 10);
      final yesterday = DateTime(2026, 9, 9);

      expect(
        () => WashItem.validateNewWashCreation(
          washDate: yesterday,
          referenceToday: today,
        ),
        throwsA(isA<ValidationException>()),
      );

      // Today or future should pass
      expect(
        () => WashItem.validateNewWashCreation(
          washDate: today,
          referenceToday: today,
        ),
        returnsNormally,
      );
      expect(
        () => WashItem.validateNewWashCreation(
          washDate: DateTime(2026, 9, 11),
          referenceToday: today,
        ),
        returnsNormally,
      );
    });

    test('JSON serialization and deserialization roundtrip', () {
      final original = WashItem(
        id: 'wash-100',
        washDate: DateTime(2026, 9, 10),
        expectedRetrieveDate: DateTime(2026, 9, 12),
        status: WashStatus.completed,
        isSuccessfullyTracked: true,
        quantities: ClothingQuantities({
          ClothingCategory.shirts: 2,
          ClothingCategory.trousers: 3,
        }),
      );

      final json = original.toJson();
      final restored = WashItem.fromJson(json);

      expect(restored, original);
      expect(restored.totalClothes, 5);
      expect(restored.status, WashStatus.completed);
      expect(restored.isSuccessfullyTracked, true);
    });
  });
}
