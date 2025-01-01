import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_b8_backend/models/category.dart';

class CategoryServices {
  Stream<List<CategoryModel>> getAllCategories() {
    return FirebaseFirestore.instance
        .collection('categoryCollection')
        .snapshots()
        .map((taskList) => taskList.docs
            .map((taskModel) => CategoryModel.fromJson(taskModel.data()))
            .toList());
  }
}
