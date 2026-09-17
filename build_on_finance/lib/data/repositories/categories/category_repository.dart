import '../../../models/categories/category.dart';
import '../../database_helper.dart';
import '../repository.dart';

class CategoryRepository implements Repository<Category> {
  final DatabaseHelper _dbHelper;

  CategoryRepository({DatabaseHelper? dbHelper})
    : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  @override
  Future<int> insert(Category item) async {
    final db = await _dbHelper.database;
    return db.insert('categories', item.toMap());
  }

  @override
  Future<Category?> getById(int id) async {
    final db = await _dbHelper.database;
    final maps = await db.query('categories', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Category.fromMap(maps.first);
  }

  @override
  Future<List<Category>> getAll() async {
    final db = await _dbHelper.database;
    final maps = await db.query('categories');
    return maps.map((m) => Category.fromMap(m)).toList();
  }

  @override
  Future<int> update(Category item) async {
    final db = await _dbHelper.database;
    return db.update(
      'categories',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }
}
