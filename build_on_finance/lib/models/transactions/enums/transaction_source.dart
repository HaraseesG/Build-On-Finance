enum TransactionSource {
  manual,
  auto;

  String toDb() => name;

  static TransactionSource fromDb(String value) {
    return TransactionSource.values.firstWhere(
      (e) => e.name == value,
      orElse: () => throw ArgumentError('Unknown source: $value'),
    );
  }
}
