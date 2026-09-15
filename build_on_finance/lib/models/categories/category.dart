class Category {
  final int? id;
  final String name;
  final int? parentId;
  final double? budgetMonthly;

  const Category({
    this.id,
    required this.name,
    this.parentId,
    this.budgetMonthly,
  });

  factory Category.fromMap(Map<String, Object?> map) {
    return Category(
      id: map['id'] as int?,
      name: map['name'] as String,
      parentId: map['parent_id'] as int?,
      budgetMonthly: map['budget_monthly'] as double?,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'parent_id': parentId,
      'budget_monthly': budgetMonthly,
    };
  }

  Category copyWith({
    int? id,
    String? name,
    int? parentId,
    double? budgetMonthly,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      budgetMonthly: budgetMonthly ?? this.budgetMonthly,
    );
  }
}
