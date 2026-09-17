import '../../../models/goals/goal.dart';
import '../../database_helper.dart';
import '../repository.dart';

class GoalRepository implements Repository<Goal> {
  final DatabaseHelper _dbHelper;

  GoalRepository({DatabaseHelper? dbHelper})
    : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  @override
  Future<int> insert(Goal item) async {
    final db = await _dbHelper.database;
    return db.insert('goals', item.toMap());
  }

  @override
  Future<Goal?> getById(int id) async {
    final db = await _dbHelper.database;
    final maps = await db.query('goals', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Goal.fromMap(maps.first);
  }

  @override
  Future<List<Goal>> getAll() async {
    final db = await _dbHelper.database;
    final maps = await db.query('goals');
    return maps.map((m) => Goal.fromMap(m)).toList();
  }

  @override
  Future<int> update(Goal item) async {
    final db = await _dbHelper.database;
    return db.update(
      'goals',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return db.delete('goals', where: 'id = ?', whereArgs: [id]);
  }
}
