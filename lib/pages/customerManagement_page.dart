import 'package:flutter/material.dart';
import 'package:prestapp/models/person_model.dart';

class CustomerManagementPage extends StatefulWidget {
  @override
  _CustomerManagementPageState createState() => _CustomerManagementPageState();
}

class _CustomerManagementPageState extends State<CustomerManagementPage> {
  Person person = new Person();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
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

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            children: <Widget>[
              TextFormField(
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
              RaisedButton(
                onPressed: _validateInputs,
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xffff835f),
                          Color(0xFFff9320),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(80.0))),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 70, vertical: 15.0),
                  child: const Text('GUARDAR', style: TextStyle(fontSize: 15)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
