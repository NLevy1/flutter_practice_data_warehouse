import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';


Future<String> database_setup_and_return_version() async {
  var factory = databaseFactoryFfiWeb;
  var db = await factory.openDatabase ('my_db.db');
  var sqliteVersion = (await db.rawQuery('select sqlite_version()')).first.values.first;
  return sqliteVersion;
}

void main() async {
  print(await database_setup_and_return_version());
}