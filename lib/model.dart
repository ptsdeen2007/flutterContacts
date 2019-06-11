// To parse this JSON data, do
//
//     final note = noteFromJson(jsonString);

import 'dart:convert';

Contacts noteFromJson(String str) => Contacts.fromMap(json.decode(str));

String noteToJson(Contacts data) => json.encode(data.toMap());

class Contacts {
  String name;
  String place;
  String path;

  Contacts({
    this.name,
    this.place,
    this.path,
  });

  factory Contacts.fromMap(Map<String, dynamic> json) => new Contacts(
    name: json["name"],
    place: json["place"],
    path: json["path"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "place": place,
    "path": path,
  };
}
