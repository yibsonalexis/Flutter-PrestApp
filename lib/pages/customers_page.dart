import 'package:flutter/material.dart';
import 'package:prestapp/models/person_model.dart';
import 'package:prestapp/providers/db_provider.dart';

class CustomersPage extends StatefulWidget {
  @override
  _CustomersPageState createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _customersList(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, "customerManagement");
        },
        child: Icon(Icons.person_add),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _appBar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      title: Text("PrestApp", style: TextStyle(color: Colors.white),),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          color: Colors.white,
          onPressed: () {},
        )
      ],
    );
  }

  Widget _customersList(BuildContext context) {
    return FutureBuilder(
      future: DBProvider.db.getPersons(),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List<Person>> snapshot) {
        if (snapshot.hasData) {
          final persons = snapshot.data;
          return ListView.builder(
            itemCount: persons.length,
            itemBuilder: (BuildContext context, int i) =>
                _cardPerson(persons[i], context),
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

  Widget _cardPerson(Person person, BuildContext context) {
    return Card(
      child: Dismissible(
        key: UniqueKey(),
        confirmDismiss: (DismissDirection direction) async {
          if (direction == DismissDirection.endToStart) {
            Navigator.pushNamed(context, "customerManagement",
                arguments: person);
            return false;
          }
          return _showConfirmationDialog(context, person);
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
            backgroundImage: AssetImage("assets/img/user.png"),
          ),
          title: Text("${person.name} ${person.lname}"),
          subtitle: Text(person.identification),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.pushNamed(context, "customerDetail", arguments: person);
          },
        ),
      ),
    );
  }

  Future<bool> _showConfirmationDialog(BuildContext context, Person person) async {
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
                DBProvider.db.deletePerson(person.id);
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
