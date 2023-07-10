import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  //USE Table name device-profiles
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    print("🎭🎐🎍🎟🎭");
    return sql.openDatabase(('${dbPath}device-profiles.db'),
        onCreate: (db, version) {
      print("🎭🎭");
      return db.execute(
          'CREATE TABLE device_profiles(id PRIMARY KEY, name TEXT, email TEXT, phone TEXT, latitude TEXT, longitude TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    print("🎍");

    db.rawInsert("INSERT INTO $table (id,name,email,phone,latitude,longitude)"
        "VALUES (${data['id']}, ${data['name']},${data['email']}, ${data['phone']}, ${data['longitude']},${data['latitude']})");
    // db.insert(
    //   table,
    //   data,
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );
    print("🎍🎍🎍🎍");
  }

  static Future<List<Map<String, dynamic>>> getAllData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
