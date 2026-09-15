enum TransactionDirection {
  debit,
  credit;

  String toDb() => name;

  static TransactionDirection fromDb(String value) {
    return TransactionDirection.values.firstWhere(
      (e) => e.name == value,
      orElse: () => throw ArgumentError('Unknown direction: $value'),
    );
  }
}
