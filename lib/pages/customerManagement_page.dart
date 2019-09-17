import 'package:flutter/material.dart';

class CustomerManagementPage extends StatefulWidget {
  @override
  _CustomerManagementPageState createState() => _CustomerManagementPageState();
}

class _CustomerManagementPageState extends State<CustomerManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text("Agregar Cliente"),
    );
  }

  Widget _body() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
      children: <Widget>[
        TextField(
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Indetificación del cliente",
            labelText: "Indetificación",
            icon: Icon(Icons.perm_identity),
            // prefixIcon: Icon(Icons.account_circle),
            suffixIcon: Icon(Icons.person),
          ),
        ),
        Divider(),
        TextField(
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Nombre del cliente",
            labelText: "Nombre",
            icon: Icon(Icons.account_box),
            // prefixIcon: Icon(Icons.account_circle),
            suffixIcon: Icon(Icons.accessibility_new),
          ),
        ),
        Divider(),
        TextField(
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Apellido del cliente",
            labelText: "Apellido",
            icon: Icon(Icons.person_outline),
            prefixIcon: Icon(Icons.account_circle),
            suffixIcon: Icon(Icons.person_outline),
          ),
        ),
        Divider(),
        TextField(
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Apellido del cliente",
            labelText: "Apellido",
            icon: Icon(Icons.person_outline),
            prefixIcon: Icon(Icons.account_circle),
            suffixIcon: Icon(Icons.person_outline),
          ),
        ),
        Divider(),
        TextField(
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Apellido del cliente",
            labelText: "Apellido",
            icon: Icon(Icons.person_outline),
            prefixIcon: Icon(Icons.account_circle),
            suffixIcon: Icon(Icons.person_outline),
          ),
        ),
        Divider(),
        TextField(
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Apellido del cliente",
            labelText: "Apellido",
            icon: Icon(Icons.person_outline),
            prefixIcon: Icon(Icons.account_circle),
            suffixIcon: Icon(Icons.person_outline),
          ),
        ),
        Divider(),
      ],
    );
  }
}
