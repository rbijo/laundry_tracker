import '../../core/errors/validation_exception.dart';
import 'clothing_quantities.dart';
import 'wash_status.dart';

/// Wash record representing an active or completed laundry batch.
class WashItem {
  final String id;
  final DateTime washDate;
  final DateTime? expectedRetrieveDate;
  final WashStatus status;
  final bool isSuccessfullyTracked;
  final ClothingQuantities quantities;
  final DateTime createdAt;
  final DateTime updatedAt;

  WashItem({
    required this.id,
    required this.washDate,
    this.expectedRetrieveDate,
    this.status = WashStatus.inProgress,
    this.isSuccessfullyTracked = false,
    ClothingQuantities? quantities,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : quantities = quantities ?? ClothingQuantities.empty(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now() {
    _validateIntegrity();
  }

  /// Truncates a DateTime to midnight (date only) for accurate date comparisons.
  static DateTime toDateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

  /// Validates new wash integrity rules.
  void _validateIntegrity() {
    if (id.trim().isEmpty) {
      throw const ValidationException('Wash ID cannot be empty', field: 'id');
    }

    // Expected Retrieve Date must not be earlier than Wash Date
    if (expectedRetrieveDate != null) {
      final dateWash = toDateOnly(washDate);
      final dateRetrieve = toDateOnly(expectedRetrieveDate!);
      if (dateRetrieve.isBefore(dateWash)) {
        throw const ValidationException(
          'Expected Retrieve Date cannot be earlier than Wash Date',
          field: 'expectedRetrieveDate',
        );
      }
    }
  }

  /// Validates rules specific to creating a new wash (washDate not in the past).
  static void validateNewWashCreation({
    required DateTime washDate,
    DateTime? expectedRetrieveDate,
    DateTime? referenceToday,
  }) {
    final today = toDateOnly(referenceToday ?? DateTime.now());
    final wash = toDateOnly(washDate);

    if (wash.isBefore(today)) {
      throw const ValidationException(
        'Wash date cannot be in the past',
        field: 'washDate',
      );
    }

    if (expectedRetrieveDate != null) {
      final retrieve = toDateOnly(expectedRetrieveDate);
      if (retrieve.isBefore(wash)) {
        throw const ValidationException(
          'Expected Retrieve Date cannot be earlier than Wash Date',
          field: 'expectedRetrieveDate',
        );
      }
    }
  }

  /// Total number of clothes dynamically derived from clothing quantities.
  int get totalClothes => quantities.total;

  /// Convenience getter to check if wash is active.
  bool get isInProgress => status == WashStatus.inProgress;

  /// Convenience getter to check if wash is completed.
  bool get isCompleted => status == WashStatus.completed;

  /// Creates a copy with specified fields replaced.
  WashItem copyWith({
    String? id,
    DateTime? washDate,
    DateTime? expectedRetrieveDate,
    WashStatus? status,
    bool? isSuccessfullyTracked,
    ClothingQuantities? quantities,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WashItem(
      id: id ?? this.id,
      washDate: washDate ?? this.washDate,
      expectedRetrieveDate: expectedRetrieveDate ?? this.expectedRetrieveDate,
      status: status ?? this.status,
      isSuccessfullyTracked: isSuccessfullyTracked ?? this.isSuccessfullyTracked,
      quantities: quantities ?? this.quantities,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'washDate': washDate.toIso8601String(),
      'expectedRetrieveDate': expectedRetrieveDate?.toIso8601String(),
      'status': status.toJson(),
      'isSuccessfullyTracked': isSuccessfullyTracked,
      'quantities': quantities.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory WashItem.fromJson(Map<String, dynamic> json) {
    return WashItem(
      id: json['id'] as String,
      washDate: DateTime.parse(json['washDate'] as String),
      expectedRetrieveDate: json['expectedRetrieveDate'] != null
          ? DateTime.parse(json['expectedRetrieveDate'] as String)
          : null,
      status: WashStatus.fromJson(json['status'] as String?),
      isSuccessfullyTracked: json['isSuccessfullyTracked'] as bool? ?? false,
      quantities: ClothingQuantities.fromJson(json['quantities'] as Map<String, dynamic>?),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WashItem) return false;
    return id == other.id &&
        washDate == other.washDate &&
        expectedRetrieveDate == other.expectedRetrieveDate &&
        status == other.status &&
        isSuccessfullyTracked == other.isSuccessfullyTracked &&
        quantities == other.quantities;
  }

  @override
  int get hashCode => Object.hash(
        id,
        washDate,
        expectedRetrieveDate,
        status,
        isSuccessfullyTracked,
        quantities,
      );

  @override
  String toString() =>
      'WashItem(id: , washDate: , status: , total: , tracked: )';
}
