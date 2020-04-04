import 'package:flutter/foundation.dart';
import 'package:prestapp/models/fees_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:prestapp/providers/db_provider.dart';

class DBFeesProvider with ChangeNotifier {
  DBFeesProvider();
  static final DBFeesProvider db = DBFeesProvider._();
  DBFeesProvider._();

  Future<int> createFees(Fees fees) async {    
    final Database db = await DBProvider.db.database;
    final res = await db.insert("Fees", fees.toJson());
    notifyListeners();
    return res;
  }

  Future<Fees> getFeesById(int feesId) async {
    final Database db = await DBProvider.db.database;
    final res =
        await db.query("Fees", where: "id = ?", whereArgs: [feesId]);
    return res.isNotEmpty ? Fees.fromJson(res.first) : null;
  }

  Future<List<Fees>> getFeess() async {
    final db = await DBProvider.db.database;
    final res = await db.query('Fees');
    List<Fees> feess =
        res.isNotEmpty ? res.map((p) => Fees.fromJson(p)).toList() : [];
    return feess;
  }

  Future<int> updateFees(Fees updatedFees) async {
    final db = await DBProvider.db.database;
    final res = await db.update('Fees', updatedFees.toJson(),
        where: 'id = ?', whereArgs: [updatedFees.id]);
    notifyListeners();
    return res;
  }

  Future<int> deleteFees(int feesId) async {
    final db = await DBProvider.db.database;
    final res =
        await db.delete('Fees', where: 'id = ?', whereArgs: [feesId]);
    notifyListeners();
    return res;
  }
}