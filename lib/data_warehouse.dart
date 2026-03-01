import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseOperator {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    var factory = databaseFactoryFfiWeb;
    _database = await factory.openDatabase(
      'my_db.db',
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
        create table tasks (
        id integer primary key autoincrement,
        task_name text)
        ''');
        },
      ),
    );
    return _database!;
  }

  static Future<String> returnDatabaseVersion() async {
    final db = await getDatabase();
    var sqliteVersion = (await db.rawQuery(
      'select sqlite_version()',
    )).first.values.first;
    return sqliteVersion.toString();
  }

  static Future<void> insertTask(String taskName) async {
    final db = await getDatabase();
    await db.insert('tasks', {'task_name': taskName});
  }

  static Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await getDatabase();
    return await db.query('tasks');
  }

  static Future<void> deleteTask(int id) async {
    final db = await getDatabase();
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}

Future<String> databaseSetupAndReturnVersion() async {
  var factory = databaseFactoryFfiWeb;
  var db = await factory.openDatabase('my_db.db');
  var sqliteVersion = (await db.rawQuery(
    'select sqlite_version()',
  )).first.values.first;
  return sqliteVersion.toString();
}
