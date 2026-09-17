import '../../../models/accounts/account.dart';
import '../../database_helper.dart';
import '../repository.dart';

class AccountRepository implements Repository<Account> {
  final DatabaseHelper _dbHelper;

  AccountRepository({DatabaseHelper? dbHelper})
    : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  @override
  Future<int> insert(Account item) async {
    final db = await _dbHelper.database;
    return db.insert('accounts', item.toMap());
  }

  @override
  Future<Account?> getById(int id) async {
    final db = await _dbHelper.database;
    final maps = await db.query('accounts', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Account.fromMap(maps.first);
  }

  @override
  Future<List<Account>> getAll() async {
    final db = await _dbHelper.database;
    final maps = await db.query('accounts');
    return maps.map((m) => Account.fromMap(m)).toList();
  }

  @override
  Future<int> update(Account item) async {
    final db = await _dbHelper.database;
    return db.update(
      'accounts',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return db.delete('accounts', where: 'id = ?', whereArgs: [id]);
  }
}
