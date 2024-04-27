// To parse this JSON data, do
//
//     final userData = userDataFromMap(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserData userDataFromMap(String str) => UserData.fromMap(json.decode(str));

String userDataToMap(UserData data) => json.encode(data.toMap());

class UserData {
  String? name;
  String? uuid;
  String? email;
  Timestamp? lastlogin;
  List<dynamic>? myChats;

  UserData({
    this.name,
    this.uuid,
    this.email,
    this.lastlogin,
    this.myChats,
  });

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
    name: json["name"],
    uuid: json["uuid"],
    email: json["email"],
    lastlogin: json["lastlogin"],
    myChats: json["my_chats"] == null ? [] : List<dynamic>.from(json["my_chats"]!.map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "uuid": uuid,
    "email": email,
    "lastlogin": lastlogin,
    "my_chats": myChats == null ? [] : List<dynamic>.from(myChats!.map((x) => x)),
  };
}
