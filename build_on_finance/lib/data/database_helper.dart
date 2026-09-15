import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'budget_tracker.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE accounts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        last4 TEXT,
        type TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        parent_id INTEGER,
        budget_monthly REAL,
        FOREIGN KEY (parent_id) REFERENCES categories (id)
      )
    ''');
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        account_id INTEGER NOT NULL,
        category_id INTEGER,
        amount REAL NOT NULL,
        direction TEXT NOT NULL CHECK (direction IN ('debit', 'credit')),
        merchant_raw TEXT,
        description TEXT,
        date TEXT NOT NULL,
        source TEXT NOT NULL CHECK (source IN ('manual', 'auto')),
        FOREIGN KEY (account_id) REFERENCES accounts (id),
        FOREGIN KEY (category_id REFERENCES categories (id)
      )
    ''');
    await db.execute('''
      CREATE TABLE merchant_rules (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pattern TEXT NOT NULL,
        category_id INTEGER NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories (id)
      )
    ''');
    await db.execute('''
      CREATE TABLE goals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        target_amount REAL NOT NULL,
        target_date TEXT,
        linked_category_id INTEGER,
        FOREIGN KEY (linked_category_id) REFERENCES categories (id)
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Versioned migrations go here as the schema evolves
  }
}
