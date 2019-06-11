import 'dart:io';

import 'package:flutter/material.dart';

import 'constants.dart';
import 'db_helper.dart';
import 'model.dart';

class ShowContacts extends StatefulWidget {
  @override
  _ShowContactsState createState() => _ShowContactsState();
}

class _ShowContactsState extends State<ShowContacts> {
  var contacts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shwo contacts"),
      ),
      body: ListView.builder(
          itemCount: contacts == null ? 0 : contacts.length,
          itemBuilder: (context, cout) {
            Contacts cts = Contacts.fromMap(contacts[cout]);
            return Card(
                child: ListTile(
              title: Text(cts.name),
              subtitle: Text(cts.place),
              leading: new ClipRRect(
                borderRadius: new BorderRadius.circular(40.0),
                child: Image.file(File(cts.path)),
              ),
            ));
          }),
    );
  }

  @override
  void initState() {
    DatabaseHelper helper = DatabaseHelper.make();
    var notes = helper.getAllNotes();
    notes.then((nots) {
      setState(() {
        contacts = nots;
      });
    });
  }
}

/*
Card(
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Column(
children: <Widget>[
Padding(
padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
child: Row(children: <Widget>[
Text(cts.name.toString()),
Expanded(child: Container()),
Text(cts.place.toString())
]),
),
Image.file(File(cts.path))
],
),
),
);*/
