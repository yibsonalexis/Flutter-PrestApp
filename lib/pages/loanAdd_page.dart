import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prestapp/models/person_model.dart';
import 'package:prestapp/providers/db_provider.dart';

class LoanAddPage extends StatefulWidget {
  @override
  _LoanAddPageState createState() => _LoanAddPageState();
}

class _LoanAddPageState extends State<LoanAddPage> {
    Person person = new Person();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  double _buttonSaveWidth = 300.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
        title: Text("AGREGAR PRESTAMO", ),        
      ),
      body: _body(context),
      
    );
  }

   void _validateInputs() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(person.name);
      print(person.landline);
      print(person.email);
      person.adminId = 1;
      setState(() {
        _buttonSaveWidth = 50.0;
      });
      final cp = await DBProvider.db.createPerson(person);
      if (cp > 0) {
        Timer(Duration(milliseconds: 800), () {
          Navigator.pop(context);
        });
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: person.identification,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Indetificación del cliente",
                  labelText: "Indetificación",
                  icon: Icon(Icons.contacts),
                  suffixIcon: Icon(Icons.chrome_reader_mode),
                ),
                onSaved: (value) => person.identification = value,
                validator: (value) {
                  if (value.isEmpty) return "El campo es requerido";
                  return null;
                },
              ),
              Divider(),
              TextFormField(
                initialValue: person.name,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nombre del cliente",
                  labelText: "Nombre",
                  icon: Icon(Icons.account_box),
                  suffixIcon: Icon(Icons.accessibility_new),
                ),
                onSaved: (value) => person.name = value,
                validator: (value) {
                  if (value.length < 1) return "El campo es requerido";
                  return null;
                },
              ),
              Divider(),
              TextFormField(
                initialValue: person.lname,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Apellido del cliente",
                  labelText: "Apellido",
                  icon: Icon(Icons.person_pin),
                  suffixIcon: Icon(Icons.person_outline),
                ),
                onSaved: (value) => person.lname = value,
                validator: (value) {
                  if (value.length < 1) return "El campo es requerido";
                  return null;
                },
              ),
              Divider(),
              TextFormField(
                initialValue: person.addres,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Dirección del cliente",
                  labelText: "Dirección",
                  icon: Icon(Icons.directions),
                  suffixIcon: Icon(Icons.my_location),
                ),
                onSaved: (value) => person.addres = value,
              ),
              Divider(),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                initialValue: person.email,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Email del cliente",
                  labelText: "Email",
                  icon: Icon(Icons.contact_mail),
                  suffixIcon: Icon(Icons.alternate_email),
                ),
                onSaved: (value) => person.email = value,
              ),
              Divider(),
              TextFormField(
                initialValue: person.cellPhone,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Teléfono móvil del cliente",
                  labelText: "Teléfono móvil",
                  icon: Icon(Icons.phone_android),
                  suffixIcon: Icon(Icons.speaker_phone),
                ),
                onSaved: (value) => person.cellPhone = value,
              ),
              Divider(),
              TextFormField(
                initialValue: person.landline,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Teléfono fijo del cliente",
                  labelText: "Teléfono fijo",
                  icon: Icon(Icons.contact_phone),
                  suffixIcon: Icon(Icons.phone),
                ),
                onSaved: (value) => person.landline = value,
              ),
              Divider(),
              InkWell(
                onTap: _validateInputs,
                borderRadius: BorderRadius.circular(25.0),
                child: AnimatedContainer(
                    width: _buttonSaveWidth,
                    height: 50.0,
                    duration: Duration(milliseconds: 300),
                    alignment: FractionalOffset.center,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xffff835f),
                            Color(0xFFff9320),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(80.0))),
                    // padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15.0),
                    child: _buttonSaveWidth > 60.0
                        ? new Text(
                            "GUARDAR",
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              letterSpacing: 0.8,
                            ),
                          )
                        : _buttonSaveWidth <= 50.0
                            ? new CircularProgressIndicator(
                                value: null,
                                strokeWidth: 1.0,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              )
                            : null),
              ),              
            ],
          ),
        ),
      ),
    );
  }
}