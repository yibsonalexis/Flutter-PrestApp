import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:prestapp/appTheme.dart';
import 'package:prestapp/models/fees_model.dart';
import 'package:prestapp/providers/db_fees_provider.dart';
import 'package:provider/provider.dart';

class CustomDialogFees extends StatefulWidget {
  @override
  _CustomDialogFeesState createState() => _CustomDialogFeesState();
}

class _CustomDialogFeesState extends State<CustomDialogFees> {
  Fees fees = new Fees();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;

  double _buttonSaveWidth = 200.0;

  TextEditingController _inputDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
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
      setState(() {
        _buttonSaveWidth = 50.0;
      });
      final clp = Provider.of<DBFeesProvider>(context);
      final cl = await clp.createFees(fees);
      // final cl = await DBFeesProvider.db.createFees(fees);
      print(cl);
      if (cl > 0) {
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
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Column(
                children: <Widget>[
                  TextFormField(
                    initialValue:
                        fees.value != null ? fees.value.toString() : '',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Valor del prestamo",
                      labelText: "Valor",
                      icon: Icon(Icons.monetization_on),
                      suffixIcon: Icon(Icons.attach_money),
                    ),
                    onSaved: (value) => fees.value =
                        value != '' ? double.parse(value) : null,
                    validator: (value) {
                      if (value.isEmpty) return "El campo es requerido";
                      return null;
                    },
                  ),
                  Divider(),
                  TextFormField(
                    // initialValue: fees.date != null ? fees.date : '',
                    controller: _inputDateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Fecha del prestamo",
                      labelText: "Fecha",
                      icon: Icon(Icons.calendar_today),
                      suffixIcon: Icon(Icons.date_range),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      _selectDate(context);
                    },
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
                                colors: AppTheme.colorsGradient,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius:
                                BorderRadius.all(Radius.circular(80.0))),
                        // padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15.0),
                        child: _buttonSaveWidth > 60.0
                            ? new Text(
                                "GUARDAR CUOTA",
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                ),
                              )
                            : _buttonSaveWidth <= 50.0
                                ? new CircularProgressIndicator(
                                    value: null,
                                    strokeWidth: 1.0,
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                  )
                                : null),
                  ),
                ],
              ),
            ],
          ),
        ),
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
          "assets/img/coin2.png",
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime _dateNow = new DateTime.now();
    DateTime _date = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(_dateNow.year - 5),
        lastDate: new DateTime(_dateNow.year + 1));
    if (_date != null) {
      // _inputDateController
      // print(DateFormat.yMMMd().format(_date));
      fees.date = _date.millisecondsSinceEpoch.toString();
      setState(() {
        _inputDateController.text = new DateFormat.yMMMd().format(_date);
      });
    }
  }
}

class Consts {
  Consts._();
  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
