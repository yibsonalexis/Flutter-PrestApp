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

  List<Person2> _getPerson() {
    List persons = new List<Person2>();
    persons.add(new Person2("Alex", "Eudo"));
    persons.add(new Person2("Carlos", "Mark"));
    persons.add(new Person2("Juanes", "Rodriguez"));
    persons.add(new Person2("Diana", "Maradona"));
    persons.add(new Person2("Rebeca", "Leonid"));
    persons.add(new Person2("Alex", "Eudo"));
    persons.add(new Person2("Carlos", "Mark"));
    persons.add(new Person2("Juanes", "Rodriguez"));
    persons.add(new Person2("Diana", "Maradona"));
    persons.add(new Person2("Rebeca", "Leonid"));
    return persons;
  }
}

class Person2 {
  String name;
  String lname;
  Person2(this.name, this.lname);
}
