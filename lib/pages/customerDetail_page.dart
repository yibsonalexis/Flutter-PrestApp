import 'package:flutter/material.dart';
import 'package:prestapp/appTheme.dart';
import 'package:prestapp/models/loan_model.dart';
import 'package:prestapp/models/person_model.dart';
import 'package:prestapp/providers/db_loan_provider.dart';
import 'package:prestapp/utils/utils.dart';
import 'package:prestapp/widgets/alertDialog.dart';
import 'package:provider/provider.dart';

class CustomerDetailPage extends StatefulWidget {
  @override
  _CustomerDetailPageState createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
  Person person = new Person();
  double _width;

  @override
  Widget build(BuildContext context) {
    Person _argPerson = ModalRoute.of(context).settings.arguments;
    if (_argPerson != null) {
      person = _argPerson;
    }
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => CustomDialog(),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
      ),
    );
  }

  void updateListLoans() {}
  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      centerTitle: false,
      iconTheme: IconThemeData(
        color: AppTheme.nearlyBlack, //change your color here
      ),
      title: Text(
        person.name + " " + person.lname,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: AppTheme.fontName,
          fontWeight: FontWeight.w700,
          fontSize: 28.0,
          letterSpacing: 1.2,
          color: AppTheme.darkerText,
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Center(child: Text(person.identification)),
        )
      ],
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: <Widget>[
          _customerInfo(context),
          Expanded(child: _listLoand(context)),
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
            child: _cardInfoCustomer(),
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
        "assets/img/user.png",
      ),
    );
  }

  Widget _cardInfoCustomer() {
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
                        person.name + " " + person.lname,
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
                        "Identificación: " + person.identification,
                        style: AppTheme.textCardPersonDetails,
                      ),
                      if (person.addres.isNotEmpty)
                        Text(
                          "Dirección:" + person.addres,
                          style: AppTheme.textCardPersonDetails,
                        ),
                      if (person.email.isNotEmpty)
                        Text(
                          "Email: " + person.email,
                          style: AppTheme.textCardPersonDetails,
                        ),
                      if (person.cellPhone.isNotEmpty)
                        Text(
                          "Teléfono móvil: " + person.cellPhone,
                          style: AppTheme.textCardPersonDetails,
                        ),
                      if (person.landline.isNotEmpty)
                        Text(
                          "Teléfono fijo: " + person.landline,
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

  Widget _listLoand(BuildContext context) {
    return FutureBuilder(
      // future: DBLoanProvider.db.getLoans(),
      future: Provider.of<DBLoanProvider>(context).getLoans(),
      builder: (BuildContext context, AsyncSnapshot<List<Loan>> snapshot) {
        if (snapshot.hasData) {
          final loans = snapshot.data;
          return ListView.builder(
            // shrinkWrap: true,
            itemCount: loans.length,
            itemBuilder: (BuildContext context, int i) =>
                _cardLoan(context, loans[i]),
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

  Widget _cardLoan(BuildContext context, Loan loan) {
    return Card(
      child: Dismissible(
        key: UniqueKey(),
        confirmDismiss: (DismissDirection direction) async {
          if (direction == DismissDirection.endToStart) {
            Navigator.pushNamed(context, "customerManagement", arguments: loan);
            return false;
          }
          return _showConfirmationDialog(context, loan);
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
            backgroundImage: AssetImage("assets/img/cash.png"),
          ),
          title: Text("Valor: ${loan.loanValue} "),
          subtitle:
              Text("Interes ${loan.interest} \nCuotas: ${loan.numberFees}"),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.pushNamed(context, "loan", arguments: loan);
          },
        ),
      ),
    );
  }

  Future<bool> _showConfirmationDialog(BuildContext context, Loan loan) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Person"),
          content: const Text("Are you sure you wish to delete this person?"),
          actions: <Widget>[
            FlatButton(
              child: const Text('Yes'),
              onPressed: () {
                DBLoanProvider.db.deleteLoan(loan.id);
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
