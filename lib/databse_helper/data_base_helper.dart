import 'package:my_notes/model/data_entry.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'diary.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE diary_entries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            date_time TEXT,
            mood INTEGER
          )
        ''');
      },
    );
  }

  // Insert a diary entry
  Future<int> insertDiaryEntry(DiaryEntry entry) async {
    final db = await database;
    return await db.insert('diary_entries', entry.toMap());
  }

  // Fetch all diary entries
  Future<List<DiaryEntry>> getDiaryEntries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('diary_entries');

    return List.generate(maps.length, (i) {
      return DiaryEntry.fromMap(maps[i]);
    });
  }

  // Update a diary entry
  Future<int> updateDiaryEntry(DiaryEntry entry) async {
    final db = await database;
    return await db.update(
      'diary_entries',
      entry.toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  // Delete a diary entry
  Future<int> deleteDiaryEntry(int id) async {
    final db = await database;
    return await db.delete('diary_entries', where: 'id = ?', whereArgs: [id]);
  }
}
