import 'package:flutter/material.dart';
import 'package:prestapp/appTheme.dart';
import 'package:prestapp/models/person_model.dart';

class CustomDialog extends StatelessWidget {
  Person person = new Person();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  double _buttonSaveWidth = 200.0;
  final String title, description, buttonText;
  final Image image;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        card(context),
        circlularImage(),
      ],
    );
  }

  void _validateInputs() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(person.name);
      print(person.landline);
      print(person.email);
      person.adminId = 1;
      //   setState(() {
      //     _buttonSaveWidth = 50.0;
      //   });
      //   final cp = await DBProvider.db.createPerson(person);
      //   if (cp > 0) {
      //     Timer(Duration(milliseconds: 800), () {
      //       Navigator.pop(context);
      //     });
      //   }
      // } else {
      //   setState(() {
      //     _autoValidate = true;
      //   });
    }
  }

  Widget card(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Consts.avatarRadius + Consts.padding,
        bottom: Consts.padding,
        left: Consts.padding,
        right: Consts.padding,
      ),
      margin: EdgeInsets.only(top: Consts.avatarRadius),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(Consts.padding),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Column(
            children: <Widget>[
              TextFormField(
                initialValue: person.identification,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Valor del prestamo",
                  labelText: "Valor",
                  icon: Icon(Icons.monetization_on),
                  suffixIcon: Icon(Icons.attach_money),
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
                  hintText: "Intereses del prestamo",
                  labelText: "Intereses",
                  icon: Icon(Icons.trending_up),
                  suffixIcon: Icon(Icons.call_made),
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
                  hintText: "Número de cuotas",
                  labelText: "Cuotas",
                  icon: Icon(Icons.exposure),
                  suffixIcon: Icon(Icons.filter_9_plus),
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
                  hintText: "Fecha del prestamo",
                  labelText: "Fecha",
                  icon: Icon(Icons.calendar_today),
                  suffixIcon: Icon(Icons.date_range),
                ),
                onSaved: (value) => person.addres = value,
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
        ],
      ),
    );
  }

  Widget circlularImage() {
    return Positioned(
      top: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: AppTheme.nearlyBlack.withOpacity(0.4),
                offset: Offset(8.0, 8.0),
                blurRadius: 8.0),
          ],
        ),
        width: 120,
        height: 120,
        // padding: EdgeInsets.only(left: 50),
        child: Image.asset(
          "assets/img/cash.png",
        ),
      ),
    );
  }
}

class Consts {
  Consts._();
  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
