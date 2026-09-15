class Account {
  final int? id;
  final String name;
  final String? last4;
  final String type;

  const Account({this.id, required this.name, this.last4, required this.type});

  factory Account.fromMap(Map<String, Object?> map) {
    return Account(
      id: map['id'] as int?,
      name: map['name'] as String,
      last4: map['last4'] as String?,
      type: map['type'] as String,
    );
  }

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'last4': last4, 'type': type};
  }

  Account copyWith({int? id, String? name, String? last4, String? type}) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      last4: last4 ?? this.last4,
      type: type ?? this.type,
    );
  }
}
