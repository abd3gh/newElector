import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLElectors {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        num TEXT
      )
      """);
  }
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'Electors.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // insert
  static Future<int> createItem(String num) async {
    final db = await SQLElectors.db();

    final data = {'num': num};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLElectors.db();
    return db.query('items', orderBy: "id");
  }


  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLElectors.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update
  static Future<int> updateItem(
      int id, String num) async {
    final db = await SQLElectors.db();

    final data = {
      'num': num,
    };

    final result =
    await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLElectors.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}