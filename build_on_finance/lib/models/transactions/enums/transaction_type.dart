enum TransactionType {
  regular,
  transfer;

  String toDb() => name;

  static TransactionType fromDb(String value) {
    return TransactionType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => throw ArgumentError('Unknown type: $value'),
    );
  }
}
