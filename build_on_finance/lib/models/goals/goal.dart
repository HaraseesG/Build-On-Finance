class Goal {
  final int? id;
  final String name;
  final double targetAmount;
  final DateTime? targetDate;
  final int? linkedCategoryId;

  const Goal({
    this.id,
    required this.name,
    required this.targetAmount,
    this.targetDate,
    this.linkedCategoryId,
  });

  factory Goal.fromMap(Map<String, Object?> map) {
    return Goal(
      id: map['id'] as int?,
      name: map['name'] as String,
      targetAmount: map['target_amount'] as double,
      targetDate: map['target_date'] != null
          ? DateTime.parse(map['target_date'] as String)
          : null,
      linkedCategoryId: map['linkedCategoryId'] as int?,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'target_amount': targetAmount,
      'target_date': targetDate?.toIso8601String(),
      'linked_category_id': linkedCategoryId,
    };
  }

  Goal copyWith({
    int? id,
    String? name,
    double? targetAmount,
    DateTime? targetDate,
    int? linkedCategoryId,
  }) {
    return Goal(
      id: id ?? this.id,
      name: name ?? this.name,
      targetAmount: targetAmount ?? this.targetAmount,
      targetDate: targetDate ?? this.targetDate,
      linkedCategoryId: linkedCategoryId ?? this.linkedCategoryId,
    );
  }
}
