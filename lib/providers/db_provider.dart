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
      await db.execute('CREATE TABLE Person ('
          ' id INTEGER PRIMARY KEY AUTOINCREMENT,'
          ' adminId INTEGER,'
          ' name TEXT,'
          ' lname TEXT,'
          ' identification TEXT,'
          ' addres TEXT,'
          ' landline TEXT,'
          ' cellPhone TEXT,'
          ' email TEXT,'
          ' date TEXT,'
          ' img TEXT,'
          ' isActive INTEGER DEFAULT 1)');
    });
  }

//Actually this method won't use
  // Future<int> _createPersonRaw(Person p) async {
  //   final db = await database;
  //   final res = await db.rawInsert('INSERT INTO Person'
  //       ' (id, adminId, name, lname, identification, addres, landline, cellPhone, email, date, img, isActive)'
  //       ' VALUES'
  //       " ('${p.id}', )");
  //   return res;
  // }

  Future<int> createPerson(Person person) async {
    final Database db = await database;
    final res = await db.insert("Person", person.toJson());
    return res;
  }

  Future<Person> getPersonById(int personId) async {
    final Database db = await database;
    final res =
        await db.query("Person", where: "id = ?", whereArgs: [personId]);
    return res.isNotEmpty ? Person.fromJson(res.first) : null;
  }

  Future<List<Person>> getPersons() async {
    final db = await database;
    final res = await db.query('Person');
    List<Person> persons =
        res.isNotEmpty ? res.map((p) => Person.fromJson(p)).toList() : [];
    return persons;
  }

  Future<int> updatePerson(Person updatedPerson) async {
    final db = await database;
    final res = await db.update('Person', updatedPerson.toJson(),
        where: 'id = ?', whereArgs: [updatedPerson.id]);
    return res;
  }

  Future<int> deletePerson(int personId) async {
    final db = await database;
    final res =
        await db.delete('Person', where: 'id = ?', whereArgs: [personId]);
    return res;
  }
}
