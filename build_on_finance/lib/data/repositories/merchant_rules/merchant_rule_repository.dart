import '../../../models/merchant_rules/merchant_rule.dart';
import '../../database_helper.dart';
import '../repository.dart';

class MerchantRuleRepository implements Repository<MerchantRule> {
  final DatabaseHelper _dbHelper;

  MerchantRuleRepository({DatabaseHelper? dbHelper})
    : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  @override
  Future<int> insert(MerchantRule item) async {
    final db = await _dbHelper.database;
    return db.insert('merchant_rules', item.toMap());
  }

  @override
  Future<MerchantRule?> getById(int id) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      'merchant_rules',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return MerchantRule.fromMap(maps.first);
  }

  @override
  Future<List<MerchantRule>> getAll() async {
    final db = await _dbHelper.database;
    final maps = await db.query('merchant_rules');
    return maps.map((m) => MerchantRule.fromMap(m)).toList();
  }

  @override
  Future<int> update(MerchantRule item) async {
    final db = await _dbHelper.database;
    return db.update(
      'merchant_rules',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return db.delete('merchant_rules', where: 'id = ?', whereArgs: [id]);
  }

  Future<MerchantRule?> findMatchFor(String merchantRaw) async {
    final rules = await getAll();
    for (final rule in rules) {
      if (merchantRaw.toUpperCase().contains(rule.pattern.toUpperCase())) {
        return rule;
      }
    }
    return null;
  }
}
