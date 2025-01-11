// import 'dart:developer';
// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:my_notes/model/data_entry.dart';
//
// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   factory DatabaseHelper() => _instance;
//   DatabaseHelper._internal();
//
//   static Database? _database;
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }
//
//   Future<Database> _initDatabase() async {
//     final databasePath = await getDatabasesPath();
//     final path = join(databasePath, 'diary.db');
//
//     return await openDatabase(
//       path,
//       version: 3, // Incremented version to 3
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE diary_entries (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             title TEXT,
//             description TEXT,
//             date_time TEXT,
//             mood INTEGER
//           )
//         ''');
//
//         await db.execute('''
//           CREATE TABLE user_profile (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             name TEXT,
//             email TEXT UNIQUE,
//             password TEXT,
//             profile_image_path TEXT
//           )
//         ''');
//       },
//       onUpgrade: (db, oldVersion, newVersion) async {
//         if (oldVersion < 3) {
//           await db.execute('''
//             CREATE TABLE user_profile (
//               id INTEGER PRIMARY KEY AUTOINCREMENT,
//               name TEXT,
//               email TEXT UNIQUE,
//               password TEXT,
//               profile_image_path TEXT
//             )
//           ''');
//         }
//       },
//     );
//   }
//
//   // Insert a diary entry
//   Future<int> insertDiaryEntry(DiaryEntry entry) async {
//     final db = await database;
//     return await db.insert('diary_entries', entry.toMap());
//   }
//
//   // Fetch all diary entries
//   Future<List<DiaryEntry>> getDiaryEntries() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('diary_entries');
//
//     return List.generate(maps.length, (i) {
//       return DiaryEntry.fromMap(maps[i]);
//     });
//   }
//
//   // Update a diary entry
//   Future<int> updateDiaryEntry(DiaryEntry entry) async {
//     final db = await database;
//     return await db.update(
//       'diary_entries',
//       entry.toMap(),
//       where: 'id = ?',
//       whereArgs: [entry.id],
//     );
//   }
//
//   // Delete a diary entry
//   Future<int> deleteDiaryEntry(int id) async {
//     final db = await database;
//     return await db.delete('diary_entries', where: 'id = ?', whereArgs: [id]);
//   }
//
//   // Save or update user profile information
//   Future<void> saveUserProfile({
//     required String name,
//     required String email,
//     required String password,
//     File? imageFile,
//   }) async {
//     final db = await database;
//
//     String? newImagePath;
//     if (imageFile != null) {
//       // Save a copy of the image in the app's directory
//       final directory = await getApplicationDocumentsDirectory();
//       newImagePath = join(directory.path, basename(imageFile.path));
//       await imageFile.copy(newImagePath);
//     }
//
//     // Check if a user profile already exists
//     final List<Map<String, dynamic>> result = await db.query('user_profile', where: 'email = ?', whereArgs: [email]);
//
//     if (result.isEmpty) {
//       // Insert a new user profile entry
//       await db.insert('user_profile', {
//         'name': name,
//         'email': email,
//         'password': password, // Store the password (make sure to hash it in real-world apps)
//         'profile_image_path': newImagePath
//       });
//     } else {
//       // Optionally, you can update the existing profile if needed
//       await db.update(
//         'user_profile',
//         {
//           'name': name,
//           'password': password,
//           if (newImagePath != null) 'profile_image_path': newImagePath,
//         },
//         where: 'email = ?',
//         whereArgs: [email],
//       );
//     }
//   }
//
//   // Check if user exists by email and password
//   Future<bool> checkUserExistence({required String email, required String password}) async {
//     final db = await database;
//     log('hello');
//
//     // Query the user profile by email and password
//     final List<Map<String, dynamic>> result = await db.query(
//       'user_profile',
//       where: 'email = ? AND password = ?',
//       whereArgs: [email, password],
//     );
//
//     return result.isNotEmpty; // Return true if the user exists with the given email and password
//   }
//   // Retrieve user profile information
//   Future<Map<String, dynamic>?> getUserProfile() async {
//     final db = await database;
//     final List<Map<String, dynamic>> result = await db.query('user_profile');
//
//     if (result.isNotEmpty) {
//       return result.first; // Returns name, email, and profile_image_path
//     }
//     return null; // No user profile found
//   }
//
// }
import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:my_notes/model/data_entry.dart';

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
      version: 4, // Incremented version to 4
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE user_profile (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT UNIQUE,
            password TEXT,
            profile_image_path TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE diary_entries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            date_time TEXT,
            mood INTEGER,
            user_id INTEGER,
            FOREIGN KEY (user_id) REFERENCES user_profile (id) ON DELETE CASCADE
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 4) {
          await db.execute('''
            ALTER TABLE diary_entries ADD COLUMN user_id INTEGER;
          ''');
          await db.execute('''
            CREATE TABLE IF NOT EXISTS user_profile (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              email TEXT UNIQUE,
              password TEXT,
              profile_image_path TEXT
            )
          ''');
        }
      },
    );
  }

  // Insert a diary entry for a specific user
  Future<int> insertDiaryEntry(DiaryEntry entry, int userId) async {
    final db = await database;
    return await db.insert('diary_entries', {
      ...entry.toMap(),
      'user_id': userId,
    });
  }

  // Fetch all diary entries for a specific user
  Future<List<DiaryEntry>> getDiaryEntries(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db
        .query('diary_entries', where: 'user_id = ?', whereArgs: [userId]);

    return List.generate(maps.length, (i) {
      return DiaryEntry.fromMap(maps[i]);
    });
  }

  // Update a diary entry
  Future<int> updateDiaryEntry(DiaryEntry entry, int userId) async {
    final db = await database;
    return await db.update(
      'diary_entries',
      entry.toMap(),
      where: 'id = ? AND user_id = ?',
      whereArgs: [entry.id, userId],
    );
  }

  // Delete a diary entry
  Future<int> deleteDiaryEntry(int id, int userId) async {
    final db = await database;
    return await db.delete('diary_entries',
        where: 'id = ? AND user_id = ?', whereArgs: [id, userId]);
  }

  // Save or update user profile information
  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    File? imageFile,
  }) async {
    final db = await database;

    String? newImagePath;
    if (imageFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      newImagePath = join(directory.path, basename(imageFile.path));
      await imageFile.copy(newImagePath);
    }

    final List<Map<String, dynamic>> result =
        await db.query('user_profile', where: 'email = ?', whereArgs: [email]);

    if (result.isEmpty) {
      await db.insert('user_profile', {
        'name': name,
        'email': email,
        'password': password,
        'profile_image_path': newImagePath
      });
    }
    // else {
    //   await db.update(
    //     'user_profile',
    //     {
    //       'name': name,
    //       'password': password,
    //       if (newImagePath != null) 'profile_image_path': newImagePath,
    //     },
    //     where: 'email = ?',
    //     whereArgs: [email],
    //   );
    // }
  }

  // update user
  Future<int?> updateUser({
    required String name,
    required String email,
    required String password,
    File? imageFile,
  }) async {
    final db = await database;

    String? newImagePath;
    if (imageFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      newImagePath = join(directory.path, basename(imageFile.path));
      await imageFile.copy(newImagePath);
    }

    return await db.update(
      'user_profile',
      {
        'name': name,
        'password': password,
        if (newImagePath != null) 'profile_image_path': newImagePath,
      },
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  // login  user by email and password
  Future<int?> login({required String email, required String password}) async {
    final db = await database;

    final List<Map<String, dynamic>> result = await db.query(
      'user_profile',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return result.first['id'] as int; // Return user ID if found
    }
    return null;
  }

  // check user existence by email
  Future<bool> checkUserExistence({required String email}) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'user_profile',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }

  // Retrieve user profile by ID
  Future<Map<String, dynamic>?> getUserProfile(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'user_profile',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}
