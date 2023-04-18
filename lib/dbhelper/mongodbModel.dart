// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.address,
  });

  ObjectId id;
  String firstname;
  String lastname;
  String address;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "address": address,
      };
}
