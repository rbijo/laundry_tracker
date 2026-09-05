import '../../core/errors/validation_exception.dart';
import 'clothing_quantities.dart';

/// Issue record automatically generated from tracking discrepancies (e.g. Missing Cloth).
class IssueItem {
  final String id;
  final String washId;
  final DateTime recordedAt;
  final ClothingQuantities missingQuantities;
  final String? note;

  IssueItem({
    required this.id,
    required this.washId,
    required this.missingQuantities,
    DateTime? recordedAt,
    this.note,
  }) : recordedAt = recordedAt ?? DateTime.now() {
    _validateIntegrity();
  }

  void _validateIntegrity() {
    if (id.trim().isEmpty) {
      throw const ValidationException('Issue ID cannot be empty', field: 'id');
    }
    if (washId.trim().isEmpty) {
      throw const ValidationException('Associated Wash ID cannot be empty', field: 'washId');
    }
    if (missingQuantities.total <= 0) {
      throw const ValidationException(
        'An issue record must specify at least one missing clothing item',
        field: 'missingQuantities',
      );
    }
  }

  IssueItem copyWith({
    String? id,
    String? washId,
    DateTime? recordedAt,
    ClothingQuantities? missingQuantities,
    String? note,
  }) {
    return IssueItem(
      id: id ?? this.id,
      washId: washId ?? this.washId,
      recordedAt: recordedAt ?? this.recordedAt,
      missingQuantities: missingQuantities ?? this.missingQuantities,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'washId': washId,
      'recordedAt': recordedAt.toIso8601String(),
      'missingQuantities': missingQuantities.toJson(),
      'note': note,
    };
  }

  factory IssueItem.fromJson(Map<String, dynamic> json) {
    return IssueItem(
      id: json['id'] as String,
      washId: json['washId'] as String,
      recordedAt: DateTime.parse(json['recordedAt'] as String),
      missingQuantities: ClothingQuantities.fromJson(json['missingQuantities'] as Map<String, dynamic>?),
      note: json['note'] as String?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! IssueItem) return false;
    return id == other.id &&
        washId == other.washId &&
        recordedAt == other.recordedAt &&
        missingQuantities == other.missingQuantities &&
        note == other.note;
  }

  @override
  int get hashCode => Object.hash(id, washId, recordedAt, missingQuantities, note);

  @override
  String toString() =>
      'IssueItem(id: , washId: , missingTotal: , recordedAt: )';
}
