import '../../../models/transactions/transaction.dart';
import '../../database_helper.dart';
import '../repository.dart';

class TransactionRepository implements Repository<Transaction> {
  final DatabaseHelper _dbHelper;

  TransactionRepository({DatabaseHelper? dbHelper})
    : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  @override
  Future<int> insert(Transaction item) async {
    final db = await _dbHelper.database;
    return db.insert('transactions', item.toMap());
  }

  @override
  Future<Transaction?> getById(int id) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return Transaction.fromMap(maps.first);
  }

  @override
  Future<List<Transaction>> getAll() async {
    final db = await _dbHelper.database;
    final maps = await db.query('transactions', orderBy: 'date DESC');
    return maps.map((m) => Transaction.fromMap(m)).toList();
  }

  @override
  Future<int> update(Transaction item) async {
    final db = await _dbHelper.database;
    return db.update(
      'transactions',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Transaction>> getByAccountId(int accountId) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      'transactions',
      where: 'account_id = ?',
      whereArgs: [accountId],
      orderBy: 'date DESC',
    );
    return maps.map((m) => Transaction.fromMap(m)).toList();
  }
}
