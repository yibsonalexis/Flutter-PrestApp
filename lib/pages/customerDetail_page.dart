import 'package:flutter/material.dart';
import 'package:prestapp/models/person_model.dart';

class CustomerDetailPage extends StatelessWidget {
  Person person = new Person();
  double _width;
  @override
  Widget build(BuildContext context) {
    Person _argPerson = ModalRoute.of(context).settings.arguments;
    if (_argPerson != null) {
      person = _argPerson;
    }
    _width = MediaQuery.of(context).size.width;
    print(_width);

    return Scaffold(
      appBar: _appBar(),
      body: _listLoand2(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text("Detalles"),
    );
  }

  Widget _body(BuildContext context) {
    // Loan loan = new Loan();
    return Column(
      children: <Widget>[
        _customerInfo(context),
        _listLoand(context),
        // _listLoand2(context),
      ],
    );
  }

  Widget _customerInfo(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(10.0),
      color: Colors.blueGrey,
      // height: 200.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[userImage(context), _customerInfoDetail()],
      ),
    );
  }

  Widget userImage(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            padding: EdgeInsets.all(10.0),
            // color: Colors.yellow,
            child: Image.asset(
              "assets/img/user.png",
            ),
          ),
          Positioned(
            bottom: -4.0,
            right: 5.0,
            child: ButtonTheme(
              minWidth: 33.0,
              height: 33.0,
              buttonColor: Colors.white,
              child: RaisedButton(
                child: Icon(Icons.edit),
                padding: EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () {
                  Navigator.pushNamed(context, "customerManagement",
                      arguments: person);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _customerInfoDetail() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            person.name + " " + person.lname,
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
          Text(
            "Identificación: " + person.identification,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          if (person.addres.isNotEmpty)
            Text(
              "Dirección:" + person.addres,
              style: TextStyle(
                fontSize: 17.0,
              ),
            ),
          if (person.email.isNotEmpty)
            Text(
              "Email: " + person.email,
              style: TextStyle(
                fontSize: 17.0,
              ),
            ),
          if (person.cellPhone.isNotEmpty)
            Text(
              "Teléfono móvil: " + person.cellPhone,
              style: TextStyle(
                fontSize: 17.0,
              ),
            ),
          if (person.landline.isNotEmpty)
            Text(
              "Teléfono fijo: " + person.landline,
              style: TextStyle(
                fontSize: 17.0,
              ),
            ),
        ],
      ),
    );
  }

Widget _listLoand(BuildContext context){
  return Container(width: 10.0,height:  10.0);

}
  Widget _listLoand2(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Container(
          height: 50,
          color: Colors.amber[600],
          child: const Center(child: Text('Entry A')),
        ),
        Container(
          height: 50,
          color: Colors.amber[500],
          child: const Center(child: Text('Entry B')),
        ),
        Container(
          height: 50,
          color: Colors.amber[100],
          child: const Center(child: Text('Entry C')),
        ),
      ],
    );
  }

  // Widget _cardLoan(BuildContext context, Loan loan) {
  //   return Container();

  //   return Card(
  //     child: Dismissible(
  //       key: UniqueKey(),
  //       confirmDismiss: (DismissDirection direction) async {
  //         if (direction == DismissDirection.endToStart) {
  //           Navigator.pushNamed(context, "customerManagement",
  //               arguments: loan);
  //           return false;
  //         }
  //         return _showConfirmationDialog(context, loan);
  //       },
  //       background: Container(
  //         alignment: Alignment.centerLeft,
  //         padding: EdgeInsets.only(left: 20.0),
  //         color: Colors.redAccent,
  //         child: Icon(Icons.delete, color: Colors.white),
  //       ),
  //       secondaryBackground: Container(
  //         alignment: Alignment.centerRight,
  //         padding: EdgeInsets.only(right: 20.0),
  //         color: Colors.orangeAccent,
  //         child: Icon(Icons.edit, color: Colors.white),
  //       ),
  //       child: ListTile(
  //         leading: CircleAvatar(
  //           backgroundImage: AssetImage("assets/img/user.png"),
  //         ),
  //         title: Text("${loan.loanValue} ${loan.interest}"),
  //         subtitle: Text(loan.numberFees.toString()),
  //         trailing: Icon(Icons.arrow_forward_ios),
  //         onTap: () {
  //           Navigator.pushNamed(context, "customerDetail", arguments: loan);
  //         },
  //       ),
  //     ),
  //   );
  // }

  // Future<bool> _showConfirmationDialog(BuildContext context, Loan loan) async {
  //   return showDialog<bool>(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text("Delete Person"),
  //         content: const Text("Are you sure you wish to delete this person?"),
  //         actions: <Widget>[
  //           FlatButton(
  //             child: const Text('Yes'),
  //             onPressed: () {
  //               // DBProvider.db.deletePerson(person.id);
  //               Navigator.pop(context, true); // showDialog() returns true
  //             },
  //           ),
  //           FlatButton(
  //             child: const Text('No'),
  //             onPressed: () {
  //               Navigator.pop(context, false); // showDialog() returns false
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
