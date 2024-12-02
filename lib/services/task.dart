import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task.dart';

class TaskServices {
  ///Create Task
  Future createTask(TaskModel model) async {
    await FirebaseFirestore.instance
        .collection('taskCollection')
        .add(model.toJson());
  }

  ///Get All Tasks
  ///Get Completed Tasks
  ///Get InCompleted Tasks
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
