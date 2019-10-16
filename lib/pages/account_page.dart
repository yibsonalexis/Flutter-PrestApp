import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
    );
  }

  Widget _appBar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      title: Text("PrestApp", style: TextStyle(color: Colors.white),),
    );
  }
}
