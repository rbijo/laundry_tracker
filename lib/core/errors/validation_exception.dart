/// Domain validation exception thrown when data integrity rules are violated.
class ValidationException implements Exception {
  final String message;
  final String? field;

  const ValidationException(this.message, {this.field});

  @override
  String toString() {
    if (field != null) {
      return 'ValidationException(): ';
    }
    return 'ValidationException: ';
  }
}
