// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

class TaskModel {
  final String? docId;
  final String? title;
  final String? description;
  final String? categoryID;
  final String? image;
  final bool? isCompleted;
  final String? userID;
  final int? createdAt;

  TaskModel({
    this.docId,
    this.title,
    this.description,
    this.image,
    this.isCompleted,
    this.categoryID,
    this.userID,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        docId: json["docID"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        isCompleted: json["isCompleted"],
        categoryID: json["categoryID"],
        createdAt: json["createdAt"],
        userID: json["userID"],
      );

  Map<String, dynamic> toJson(String firebaseID) => {
        "docID": firebaseID,
        "title": title,
        "description": description,
        "image": image,
        "isCompleted": isCompleted,
        "categoryID": categoryID,
        "createdAt": createdAt,
        "userID": userID,
      };
}
