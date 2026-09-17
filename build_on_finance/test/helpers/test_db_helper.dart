import 'package:build_on_finance/data/database_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// import 'package:build_on_finance/data/database_helper.dart';

DatabaseHelper initTestDb() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  return DatabaseHelper.forTesting();
}

Future<void> resetTestDb(DatabaseHelper dbHelper) async {
  final db = await dbHelper.database;
  await db.delete('transactions');
  await db.delete('merchant_rules');
  await db.delete('goals');
  await db.delete('categories');
  await db.delete('accounts');
}
