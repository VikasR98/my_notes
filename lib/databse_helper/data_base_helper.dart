import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:my_notes/model/data_entry.dart';

class DatabaseHelper {
  static const String tableDiaryEntries = 'diary_entries';
  static const String tableUserProfile = 'user_profile';
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
    try {
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, 'diary.db');

      return await openDatabase(
        path,
        version: 4, // Incremented version to 4
        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE $tableUserProfile (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            uid TEXT NOT NULL,
            name TEXT,
            email TEXT UNIQUE,
            profile_image_path TEXT,
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL
          )
        ''');

          await db.execute('''
          CREATE TABLE $tableDiaryEntries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            date_time TEXT,
            mood INTEGER,
            user_id TEXT,
            created_at INTEGER NOT NULL,
             updated_at INTEGER NOT NULL,
            FOREIGN KEY (user_id) REFERENCES $tableUserProfile (uid) ON DELETE CASCADE
          )
        ''');
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 4) {
            await db.execute('''
            ALTER TABLE $tableDiaryEntries ADD COLUMN user_id TEXT;
          ''');
            await db.execute('''
            CREATE TABLE IF NOT EXISTS $tableUserProfile (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              uid TEXT NOT NULL,
              name TEXT,
              email TEXT UNIQUE,
              profile_image_path TEXT
            )
          ''');
          }
        },
      );
    } catch (e) {
      /// Either return <Database> or throw Exception
      rethrow;
    }
  }

  // Insert a diary entry for a specific user
  Future<int> insertDiaryEntry(DiaryEntry entry, String userId) async {
    try {
      final db = await database;
      return await db.insert(tableDiaryEntries, {
        ...entry.toMap(),
        'user_id': userId,
      });
    } catch (e) {
      rethrow;
    }
  }

  // Fetch all diary entries for a specific user
  Future<List<DiaryEntry>> getDiaryEntries(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db
        .query(tableDiaryEntries, where: 'user_id = ?', whereArgs: [userId]);

    return List.generate(maps.length, (i) {
      return DiaryEntry.fromMap(maps[i]);
    });
  }

  // New method to search diary entries by title
  Future<List<DiaryEntry>> searchDiaryEntriesByTitle(String title) async {
    final db = await database;

    // Use SQL `LIKE` to search for titles matching the provided text
    final List<Map<String, dynamic>> results = await db.query(
      tableDiaryEntries,
      where: 'title LIKE ?',
      whereArgs: ['%$title%'], // % is used for partial matching
    );

    return List.generate(results.length, (i) {
      return DiaryEntry.fromMap(results[i]);
    });
  }

  // Update a diary entry
  Future<int> updateDiaryEntry(DiaryEntry entry, String userId) async {
    final db = await database;
    return await db.update(
      tableDiaryEntries,
      entry.toMap(),
      where: 'id = ? AND user_id = ?',
      whereArgs: [entry.id, userId],
    );
  }

  // Delete a diary entry
  Future<int> deleteDiaryEntry(int id, String userId) async {
    final db = await database;
    return await db.delete(tableDiaryEntries,
        where: 'id = ? AND user_id = ?', whereArgs: [id, userId]);
  }

  // update user
  Future<int?> updateUser({
    required String name,
    required String email,
    File? imageFile,
  }) async {
    final db = await database;

    String? newImagePath;

    if (imageFile != null && await imageFile.exists()) {
      final directory = await getApplicationDocumentsDirectory();
      newImagePath = join(directory.path, basename(imageFile.path));

      try {
        // Clean up old image if it exists
        final oldProfile = await db.query(
          tableUserProfile,
          columns: ['profile_image_path'],
          where: 'email = ?',
          whereArgs: [email],
        );

        if (oldProfile.isNotEmpty &&
            oldProfile.first['profile_image_path'] != null) {
          final oldImagePath = oldProfile.first['profile_image_path'] as String;
          final oldFile = File(oldImagePath);
          if (await oldFile.exists()) {
            await oldFile.delete();
          }
        }

        // Copy new image to app storage
        await imageFile.copy(newImagePath);
      } catch (e) {
        throw Exception('Failed to copy or clean up image file: $e');
      }
    }

    // Update database
    int rowsAffected = await db.update(
      tableUserProfile,
      {
        'name': name,
        if (newImagePath != null) 'profile_image_path': newImagePath,
      },
      where: 'email = ?',
      whereArgs: [email],
    );

    if (rowsAffected == 0) {
      throw Exception('Failed to update user profile. Email not found: $email');
    }

    return rowsAffected;
  }

  // Retrieve user profile by ID
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      tableUserProfile,
      where: 'uid = ?',
      whereArgs: [userId],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}
