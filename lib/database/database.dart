import "dart:io";

import "package:path/path.dart";
import "package:sqflite/sqflite.dart";
import "package:yowflash/model/products.dart";
import "package:async/async.dart";

class DbHelper {
  static const databaseName = "database.db";
  static const databaseVersion = 1;
  static const tableu = "user";
  static const tablep = "produits";
  static const columnId = 'id';
  static const columnName = 'name';
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  late Database _db;
  List<Products> prod = [];

  Future<void> init() async {
    final dbfolder = await getDatabasesPath();
    if (!await Directory(dbfolder).exists()) {
      await Directory(dbfolder).create(recursive: true);
    }
    final path = join(dbfolder, databaseName);
    _db = await openDatabase(
      path,
      version: databaseVersion,
      onCreate: onCreate,
    );
  }

  Future onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableu (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,');
    await db.execute(
        'CREATE TABLE $tablep (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,');
  }

  Future<int> insertUser(Map<String, dynamic> row) async {
    return await _db.insert(tableu, row);
  }

  Future<int> insertProduit(Map<String, dynamic> row) async {
    return await _db.insert(tablep, row);
  }

  Future<String?> getUsers() async {
    var map = await _db.query(tableu, columns: ['id', 'name']);
    String? username = map[0]['name'].toString();
    return username;
  }

  Future<List<Products>> getProducts() async {
    final List<Map<String, dynamic>> jsons =
        await _db.rawQuery('SELECT * FROM $tablep');
    prod = jsons.map((e) => Products().fromJsonMap(e)).toList();
    return prod;
  }

  Future<bool> asyncInit() async {
    await _memoizer.runOnce(() async {
      await init();
      await getUsers();
      await getProducts();
    });
    return true;
  }
}
