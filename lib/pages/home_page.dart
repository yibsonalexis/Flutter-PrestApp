import 'package:flutter/material.dart';

import 'account_page.dart';
import 'customers_page.dart';
import 'report_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageCurrentIndex = 0;
  static List<Widget> _pages = <Widget>[
    ReportPage(),
    CustomersPage(),
    AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_pageCurrentIndex),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _pageCurrentIndex,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart), title: Text("REPORTES")),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), title: Text("CLIENTES")),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_applications), title: Text("CUENTA"))
      ],
    );
  }

  void _onItemTapped(int index) {
    print("object $index");
    setState(() {
      _pageCurrentIndex = index;
    });
  }
}
