class MerchantRule {
  final int? id;
  final String pattern;
  final int categoryId;

  const MerchantRule({
    this.id,
    required this.pattern,
    required this.categoryId,
  });

  factory MerchantRule.fromMap(Map<String, Object?> map) {
    return MerchantRule(
      id: map['id'] as int?,
      pattern: map['pattern'] as String,
      categoryId: map['category_id'] as int,
    );
  }

  Map<String, Object?> toMap() {
    return {'id': id, 'pattern': pattern, 'category_id': categoryId};
  }

  MerchantRule copyWith({int? id, String? pattern, int? categoryId}) {
    return MerchantRule(
      id: id ?? this.id,
      pattern: pattern ?? this.pattern,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}
