import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute('''CREATE TABLE user_places (
                              id TEXT PRIMARY KEY,
                              title TEXT,
                              image text
                            );''');
      },
      version: 1,
    );
  }

  static Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database();

    final result = await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );

    db.close();

    return result;
  }

  static Future<List<Map<String, dynamic>>> select(String table) async {
    final db = await database();

    final result = await db.query(table);

    db.close();

    return result;
  }
}
