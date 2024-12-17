// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

class UserModel {
  final String? docId;
  final String? name;
  final String? email;
  final String? phone;
  final int? createdAt;

  UserModel({
    this.docId,
    this.name,
    this.email,
    this.phone,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        docId: json["docID"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson(String userID) => {
        "docID": userID,
        "name": name,
        "email": email,
        "phone": phone,
        "createdAt": createdAt,
      };
}
