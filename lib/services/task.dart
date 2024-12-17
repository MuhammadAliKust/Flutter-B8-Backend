import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:firebase_auth/firebase_auth.dart';

import '../models/task.dart';

class TaskServices {
  ///Create Task
  Future createTask(TaskModel model) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('taskCollection').doc();
    await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }

  ///Get All Tasks
  Stream<List<TaskModel>> getAllTasks(String userID) {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('userID', isEqualTo: userID)
        .snapshots()
        .map((taskList) => taskList.docs
            .map((taskModel) => TaskModel.fromJson(taskModel.data()))
            .toList());
  }

  ///Get Completed Tasks
  Stream<List<TaskModel>> getCompletedTasks() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .map((taskList) => taskList.docs
            .map((taskModel) => TaskModel.fromJson(taskModel.data()))
            .toList());
  }

  ///Get InCompleted Tasks
  Stream<List<TaskModel>> getInCompletedTasks() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .map((taskList) => taskList.docs
            .map((taskModel) => TaskModel.fromJson(taskModel.data()))
            .toList());
  }

  ///Update Task
  Future updateTask(TaskModel model) async {
    await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .update({"title": model.title, "description": model.description});
  }

  ///Delete Task
  Future deleteTask(String taskID) async {
    await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .delete();
  }

  ///Marks Task as Complete
  Future markTaskAdComplete(String taskID) async {
    await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .update({'isCompleted': true});
  }
}
