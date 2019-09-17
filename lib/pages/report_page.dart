import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text("PrestApp"),
    );
  }
}
