import 'package:flutter_test/flutter_test.dart';
import 'package:laundry_tracker/core/errors/validation_exception.dart';
import 'package:laundry_tracker/domain/models/clothing_category.dart';
import 'package:laundry_tracker/domain/models/clothing_quantities.dart';
import 'package:laundry_tracker/domain/models/issue_item.dart';

void main() {
  group('IssueItem Tests', () {
    test('Creates valid issue item', () {
      final issue = IssueItem(
        id: 'issue-1',
        washId: 'wash-10',
        missingQuantities: ClothingQuantities({
          ClothingCategory.shirts: 1,
        }),
        note: 'White shirt missing',
      );

      expect(issue.id, 'issue-1');
      expect(issue.washId, 'wash-10');
      expect(issue.missingQuantities.total, 1);
      expect(issue.note, 'White shirt missing');
    });

    test('Throws ValidationException if issue has 0 missing clothes', () {
      expect(
        () => IssueItem(
          id: 'issue-1',
          washId: 'wash-1',
          missingQuantities: ClothingQuantities.empty(),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('Throws ValidationException if ID or Wash ID is empty', () {
      expect(
        () => IssueItem(
          id: '',
          washId: 'wash-1',
          missingQuantities: ClothingQuantities({ClothingCategory.jeans: 1}),
        ),
        throwsA(isA<ValidationException>()),
      );
      expect(
        () => IssueItem(
          id: 'issue-1',
          washId: '  ',
          missingQuantities: ClothingQuantities({ClothingCategory.jeans: 1}),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('JSON serialization and deserialization roundtrip', () {
      final original = IssueItem(
        id: 'issue-99',
        washId: 'wash-55',
        recordedAt: DateTime(2026, 9, 10, 14, 30),
        missingQuantities: ClothingQuantities({
          ClothingCategory.innerVest: 2,
        }),
        note: 'Missing during collection',
      );

      final json = original.toJson();
      final restored = IssueItem.fromJson(json);

      expect(restored, original);
      expect(restored.missingQuantities.total, 2);
    });
  });
}
