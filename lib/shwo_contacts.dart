import 'package:flutter/material.dart';


class ShowContacts extends StatefulWidget {
  @override
  _ShowContactsState createState() => _ShowContactsState();
}

class _ShowContactsState extends State<ShowContacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shwo contacts"),
      ),
      body: ListView.builder(itemCount: 2, itemBuilder:(context,cout){
        return Text("My text");
      }),
    );
  }
}
