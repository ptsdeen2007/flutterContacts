import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'db_helper.dart';
import 'model.dart';

import 'package:toast/toast.dart';

class AddContacts extends StatefulWidget {
  @override
  _AddContactsState createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  File _image;
  TextEditingController tec_name = TextEditingController();
  TextEditingController tec_place = TextEditingController();
  FocusNode myFocusnode;


  @override
  void initState() {
    myFocusnode=FocusNode();
      }

  Future getImageFile(bool isCamera) async {
    File myImage;
    if (isCamera) {
      myImage = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      myImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = myImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contacts"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                focusNode: myFocusnode,
                controller: tec_name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    labelText: "Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: tec_place,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    labelText: "Place"),
              ),
            ),
            Text("Select Photto From"),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    getImageFile(true);
                  },
                  child: Text("Camera"),
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    getImageFile(false);
                  },
                  child: Text("Gallary"),
                ),
              ],
            ),
            _image == null
                ? Container(
                    child: SizedBox(
                      height: 300,
                      width: 300,
                    ),
                  )
                : Image.file(
                    File(_image.path),
                    width: 300,
                    height: 300,
                  ),
            RaisedButton(
              onPressed: () {
                saveContacts();
              },
              child: Text("Save Contacts"),
            ),
          ],
        ),
      ),
    );
  }

  void saveContacts() {
    var name = tec_name.text.toString().trim();
    if (name.isEmpty) {
      print("name is empty");
      Toast.show("name is empty", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      return;
    }
    var place = tec_place.text.toString().trim();
    if(place.isEmpty){
      print("place is empty");
      Toast.show("place is empty",context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
      return;
    }
    if (_image == null) {
      print("Image is empty");
      Toast.show("Image is empty", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      return;
    }

    print("valid");
    Contacts contacts =
        Contacts(name: name, place: place, path: _image.path);
    DatabaseHelper helper = DatabaseHelper.make();
    var insert = helper.insertNote(contacts);
    insert.then((okay) {
      print("Done");
      FocusScope.of(context).requestFocus(myFocusnode);
      setState(() {
      _image=null;
      tec_name.text="";
      tec_place.text="";

      });
    });
  }

  @override
  void dispose() {
    myFocusnode.dispose();
  }


}
