import 'package:flutter/material.dart';
class LoanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
        title: Text("Loan Details"),
      ),
      
    );
  }
}