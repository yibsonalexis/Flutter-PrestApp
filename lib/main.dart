import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestapp/pages/loanAdd_page.dart';
import 'package:prestapp/pages/loan_page.dart';
import 'package:prestapp/utils/utils.dart';

import 'pages/home_page.dart';
import 'package:prestapp/pages/customerDetail_page.dart';
import 'package:prestapp/pages/customerManagement_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.light : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PrestApp',
      theme: ThemeData(
        primaryColor: HexColor("#FF8B46"),
        scaffoldBackgroundColor: const Color(0xFFEFEFEF),
        // primaryColor: Color(0xfff29e2e)

      ),
      initialRoute: "home",
      routes: {
        "home": (BuildContext context) => HomePage(),
        "customerDetail": (BuildContext context) => CustomerDetailPage(),
        "customerManagement": (BuildContext context) => CustomerManagementPage(),
        "loan": (BuildContext context) => LoanPage(),
        "loanAdd": (BuildContext context) => LoanAddPage(),
      },
    );
  }
}
