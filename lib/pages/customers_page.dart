import 'package:flutter/material.dart';

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
      title: Text("PrestApp"),
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
    return ListView(
      padding: EdgeInsets.all(5.0),
      children: _getPerson()
          .map<Widget>((item) => Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/img/user.png"),
                  ),
                  title: Text("${item.name} ${item.lname}"),
                  subtitle: Text('Here is a second line'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pushNamed(context, "customerDetail");
                  },
                ),
              ))
          .toList(),
    );
  }

  List<Person> _getPerson() {
    List persons = new List<Person>();
    persons.add(new Person("Alex", "Eudo"));
    persons.add(new Person("Carlos", "Mark"));
    persons.add(new Person("Juanes", "Rodriguez"));
    persons.add(new Person("Diana", "Maradona"));
    persons.add(new Person("Rebeca", "Leonid"));
    persons.add(new Person("Alex", "Eudo"));
    persons.add(new Person("Carlos", "Mark"));
    persons.add(new Person("Juanes", "Rodriguez"));
    persons.add(new Person("Diana", "Maradona"));
    persons.add(new Person("Rebeca", "Leonid"));
    return persons;
  }
}

class Person {
  String name;
  String lname;
  Person(this.name, this.lname);
}
