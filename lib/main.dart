import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'package:prestapp/pages/customerDetail_page.dart';
import 'package:prestapp/pages/customerManagement_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PrestApp',
      theme: ThemeData(
        primaryColor: Color(0xffff835f)
        // primaryColor: Color(0xfff29e2e)

      ),
      initialRoute: "home",
      routes: {
        "home": (BuildContext context) => HomePage(),
        "customerDetail": (BuildContext context) => CustomerDetailPage(),
        "customerManagement": (BuildContext context) => CustomerManagementPage()
      },
    );
  }
}
