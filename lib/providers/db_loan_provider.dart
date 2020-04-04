import 'package:flutter/foundation.dart';
import 'package:prestapp/models/loan_model.dart';
import 'package:sqflite/sqflite.dart';

import 'package:prestapp/providers/db_provider.dart';


class DBLoanProvider with ChangeNotifier {
  DBLoanProvider();
  static final DBLoanProvider db = DBLoanProvider._();
  DBLoanProvider._();

  Future<int> createLoan(Loan loan) async {    
    final Database db = await DBProvider.db.database;
    final res = await db.insert("Loan", loan.toJson(), conflictAlgorithm: ConflictAlgorithm.replace,);
    notifyListeners();
    return res;
  }

  Future<Loan> getLoanById(int loanId) async {
    final Database db = await DBProvider.db.database;
    final res =
        await db.query("Loan", where: "id = ?", whereArgs: [loanId]);
    return res.isNotEmpty ? Loan.fromJson(res.first) : null;
  }

  Future<List<Loan>> getLoans() async {
    final db = await DBProvider.db.database;
    final res = await db.query('Loan');
    List<Loan> loans =
        res.isNotEmpty ? res.map((p) => Loan.fromJson(p)).toList() : [];
    return loans;
  }

  Future<int> updateLoan(Loan updatedLoan) async {
    final db = await DBProvider.db.database;
    final res = await db.update('Loan', updatedLoan.toJson(),
        where: 'id = ?', whereArgs: [updatedLoan.id]);
    notifyListeners();
    return res;
  }

  Future<int> deleteLoan(int loanId) async {
    final db = await DBProvider.db.database;
    final res =
        await db.delete('Loan', where: 'id = ?', whereArgs: [loanId]);
    notifyListeners();
    return res;
  }
}