import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  //USE Table name profiles
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(('${dbPath}profiles.db'), onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE profiles(id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT, email TEXT, phone TEXT, fontSize TEXT, color TEXT, latitude TEXT, longitude TEXT)');
    }, version: 1);
  }

  static Future<List<Map<String, dynamic>>> getAllData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();

    /// *********METHOD-1*******
    // db.rawInsert("INSERT INTO $table (id,name,email,phone,latitude,longitude) "
    //     "VALUES ('${data['id']}', '${data['name']}','${data['email']}', '${data['phone']}', '${data['fontSize']}', '${data['color']}', '${data['latitude']}','${data['longitude']}')");

    /// *********METHOD-2*******
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

//   final dbData = await db.query(
//     table,
//     where: '$latitude $longitude',
//     whereArgs: [latitude, longitude],
//   );
}
