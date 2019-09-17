import 'dart:io';

import 'package:path_provider/path_provider.dart' as pB;
import 'package:prestapp/models/person_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory appDocDir = await pB.getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final String pathDB = p.join(appDocPath, "PrestApp.db");
    return await openDatabase(pathDB, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE person ('
          ' id INTEGER PRIMARY KEY,'
          ' adminId INTEGER'
          ' name TEXT'
          ' lname TEXT'
          ' identification TEXT'
          ' addres TEXT'
          ' landline TEXT'
          ' cellPhone TEXT'
          ' email TEXT'
          ' date TEXT'
          ' img TEXT'
          ' isActive INTEGER');
    });
  }

  CreatePerson(Person person) async {
    final Database db = await database;
    final res = await db.insert("person", person.toJson());
    return res;
  }

  // GetPerson(int id) async {
  //   final Database db = await database;
  //   final res = await db.query("person", where: "id = ?", whereArgs: [id]);
  //   return res.isNotEmpty ? Person.fromJson(json)
  // }
}
