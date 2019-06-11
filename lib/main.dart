import 'package:flutter/material.dart';
import 'package:flutter_contacts_app/shwo_contacts.dart';

import 'add_contacts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
//      home:AddContacts(),
    routes: <String,WidgetBuilder>{
      '/addcontacts':(BuildContext context)=>AddContacts(),
      '/showcontacts':(BuildContext context)=>ShowContacts()
    },

    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//add contacts
//show contacts
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {Navigator.of(context).pushNamed("/showcontacts");},
              child: Text("Show contact List"),
            ),RaisedButton(
              onPressed: () {Navigator.of(context).pushNamed("/addcontacts");},
              child: Text("Add contacts"),
            ),
          ],
        ),
      ),
    );
  }
}
