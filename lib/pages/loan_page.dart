import 'package:flutter/material.dart';
import 'package:prestapp/models/fees_model.dart';
import 'package:prestapp/models/loan_model.dart';
import 'package:prestapp/providers/db_fees_provider.dart';
import 'package:prestapp/utils/utils.dart';
import 'package:prestapp/widgets/alertDialogFees.dart';
import 'package:provider/provider.dart';

import '../appTheme.dart';

class LoanPage extends StatefulWidget {
  @override
  _LoanPageState createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
  Loan loan = new Loan();

  @override
  Widget build(BuildContext context) {
    Loan _argLoan = ModalRoute.of(context).settings.arguments;
    if (_argLoan != null) {
      loan = _argLoan;
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text("LOAN Details"),
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => CustomDialogFees(),
          );
        },
        child: Icon(Icons.add_box),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: <Widget>[
          _customerInfo(context),
          Expanded(child: _listFeesd(context)),
        ],
      ),
    );
  }

  Widget _customerInfo(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: _cardInfoLoan(),
          ),
          userImage(context)
        ],
      ),
    );
  }

  Widget userImage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: AppTheme.white),
        borderRadius: BorderRadius.circular(80.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: AppTheme.nearlyBlack.withOpacity(0.4),
              offset: Offset(8.0, 8.0),
              blurRadius: 8.0),
        ],
      ),
      margin: const EdgeInsets.only(left: 40.0),
      width: 60,
      height: 60,
      child: Image.asset(
        "assets/img/cash.png",
      ),
    );
  }

  Widget _cardInfoLoan() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: AppTheme.colorsGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
            topRight: Radius.circular(68.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: AppTheme.grey.withOpacity(0.6),
              offset: Offset(1.1, 1.1),
              blurRadius: 10.0),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        loan.loanValue.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          letterSpacing: 0.0,
                          color: AppTheme.white,
                        ),
                      ),
                      Text(
                        "Identificación: " + loan.loanValue.toString(),
                        style: AppTheme.textCardPersonDetails,
                      ),
                      if (loan.numberFees != 0)
                        Text(
                          "Dirección:" + loan.interest.toString(),
                          style: AppTheme.textCardPersonDetails,
                        ),
                      if (loan.date != null)
                        Text(
                          "Fecha: " + loan.date,
                          style: AppTheme.textCardPersonDetails,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.nearlyWhite,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.nearlyBlack.withOpacity(0.4),
                        offset: Offset(8.0, 8.0),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.edit,
                    color: HexColor("#FCC81A"),
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listFeesd(BuildContext context) {
    return FutureBuilder(
      // future: DBFeesProvider.db.getFeess(),
      future: Provider.of<DBFeesProvider>(context).getFeess(),
      builder: (BuildContext context, AsyncSnapshot<List<Fees>> snapshot) {
        if (snapshot.hasData) {
          print("Has data");
          final feets = snapshot.data;
          return ListView.builder(
              itemCount: feets.length,
              itemBuilder: (BuildContext context, int i) => 
               _cardFees(context, feets[i]),
              );
        } else {
          return Center(
              child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor),
          ));
        }
      },
    );
  }

  Widget _cardFees(BuildContext context, Fees fees) {
    return Card(
      child: Dismissible(
        key: UniqueKey(),
        confirmDismiss: (DismissDirection direction) async {
          if (direction == DismissDirection.endToStart) {
            Navigator.pushNamed(context, "customerManagement", arguments: loan);
            return false;
          }
          return _showConfirmationDialog(context, fees);
        },
        background: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20.0),
          color: Colors.redAccent,
          child: Icon(Icons.delete, color: Colors.white),
        ),
        secondaryBackground: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.0),
          color: Colors.orangeAccent,
          child: Icon(Icons.edit, color: Colors.white),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/img/coin2.png"),
          ),
          title: Text("Valor: ${fees.value} "),
          subtitle:
              Text("Interes ${fees.date} \nCuotas: ${loan.id}"),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.pushNamed(context, "loan", arguments: loan);
          },
        ),
      ),
    );
  }

  Future<bool> _showConfirmationDialog(BuildContext context, Fees fees) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Person"),
          content: const Text("Are you sure you wish to delete this loan?"),
          actions: <Widget>[
            FlatButton(
              child: const Text('Yes'),
              onPressed: () {
                DBFeesProvider.db.deleteFees(fees.id);
                Navigator.pop(context, true); // showDialog() returns true
              },
            ),
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context, false); // showDialog() returns false
              },
            ),
          ],
        );
      },
    );
  }
}
