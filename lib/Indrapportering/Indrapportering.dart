// @dart=2.9
import 'package:bilmekaniker_semesterprojekt/Indrapportering/view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'add.dart';
import 'database.dart';
import 'package:flutter/cupertino.dart';


class Indrapporter extends StatefulWidget {
  Indrapporter({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _IndrapporterState createState() => _IndrapporterState();
}

class _IndrapporterState extends State<Indrapporter> {
  Database db;
  List docs = [];
  initialise() {
    db = Database();
    db.initiliase();
    db.read().then((value) => {
      setState(() {
        docs = value;
      })
    });
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(48, 50, 48, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(48, 50, 48, 1.0),
        title: Text("Indrapporteret biler"),
      ),
      body: ListView.builder(
        itemCount: docs.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            View(nummerplade: docs[index], db: db)))
                    .then((value) => {
                  if (value != null) {initialise()}
                });
              },
              contentPadding: EdgeInsets.only(right: 30, left: 36),
              title: Text(docs[index]['nummerplade']),
              trailing: Text(docs[index]['indrapporter']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Add(db: db)))
              .then((value) {
            if (value != null) {
              initialise();
            }
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}