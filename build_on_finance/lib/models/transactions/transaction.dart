import 'enums/transaction_direction.dart';
import 'enums/transaction_source.dart';
import 'enums/transaction_type.dart';

class Transaction {
  final int? id;
  final int accountId;
  final int? categoryId;
  final double amount;
  final TransactionDirection direction;
  final String? merchantRaw;
  final String? description;
  final DateTime date;
  final TransactionSource source;
  final TransactionType type;
  final int? linkedTransactionId;

  const Transaction({
    this.id,
    required this.accountId,
    this.categoryId,
    required this.amount,
    required this.direction,
    this.merchantRaw,
    this.description,
    required this.date,
    required this.source,
    this.type = TransactionType.regular,
    this.linkedTransactionId,
  });

  factory Transaction.fromMap(Map<String, Object?> map) {
    return Transaction(
      id: map['id'] as int?,
      accountId: map['account_id'] as int,
      categoryId: map['category_id'] as int?,
      amount: map['amount'] as double,
      direction: TransactionDirection.fromDb(map['direction'] as String),
      merchantRaw: map['merchant_raw'] as String?,
      description: map['description'] as String?,
      date: DateTime.parse(map['date'] as String),
      source: TransactionSource.fromDb(map['source'] as String),
      type: TransactionType.fromDb(map['type'] as String),
      linkedTransactionId: map['linked_transaction_id'] as int?,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'account_id': accountId,
      'category_id': categoryId,
      'amount': amount,
      'direction': direction.toDb(),
      'merchant_raw': merchantRaw,
      'description': description,
      'date': date.toIso8601String(),
      'source': source.toDb(),
      'type': type.toDb(),
      'linked_transaction_id': linkedTransactionId,
    };
  }

  Transaction copyWith({
    int? id,
    int? accountId,
    int? categoryId,
    double? amount,
    TransactionDirection? direction,
    String? merchantRaw,
    String? description,
    DateTime? date,
    TransactionSource? source,
    TransactionType? type,
    int? linkedTransactionId,
  }) {
    return Transaction(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      direction: direction ?? this.direction,
      merchantRaw: merchantRaw ?? this.merchantRaw,
      description: description ?? this.description,
      date: date ?? this.date,
      source: source ?? this.source,
      type: type ?? this.type,
      linkedTransactionId: linkedTransactionId ?? this.linkedTransactionId,
    );
  }
}
