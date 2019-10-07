import 'package:flutter/material.dart';

class CustomerDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
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

  Widget _body() {
    return Column(
      children: <Widget>[_customerInfo(), _listLoan()],
    );
  }

  Widget _customerInfo() {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: Colors.blueGrey,
      // height: 200.0,
      child: Column(
        children: <Widget>[
          userImage(),
          SizedBox(
            width: 12.0,
          ),
          _customerInfoDetail()
        ],
      ),
    );
  }

  Widget userImage() {
    return Column(
      children: <Widget>[
        Image.asset(
          "assets/img/user.png",
          width: 80.0,
        ),
        RaisedButton(
          child: Icon(Icons.edit),
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
          
          onPressed: () {},
        )
      ],
    );
  }

  Widget _customerInfoDetail() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Naruto Uzumaki Estrada",
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
          Text(
            "Identificación:  10475422",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          Text(
            "Dirección: Naruto Uzumaki Estrada",
            style: TextStyle(
              fontSize: 17.0,
            ),
          ),
          Text(
            "Telefono: Naruto Uzumaki Estrada",
            style: TextStyle(
              fontSize: 17.0,
            ),
          ),
          Text(
            "Email: Naruto Uzumaki Estrada",
            style: TextStyle(
              fontSize: 17.0,
            ),
          )
        ],
      ),
    );
  }

  Widget _listLoan() {
    return Container();
  }
}
