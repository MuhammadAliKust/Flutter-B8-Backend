import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b8_backend/models/task.dart';
import 'package:flutter_b8_backend/services/task.dart';
import 'package:flutter_b8_backend/views/create_task.dart';
import 'package:flutter_b8_backend/views/update_task.dart';
import 'package:provider/provider.dart';

class GetCategoryTaskView extends StatelessWidget {
  final String categoryID;

  const GetCategoryTaskView({super.key, required this.categoryID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Get All Task"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateTaskView()));
          },
          child: const Icon(Icons.add),
        ),
        body: StreamProvider.value(
          value: TaskServices().getTaskByCategoryID(categoryID),
          initialData: [TaskModel()],
          builder: (context, child) {
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    // leading: Image.network(taskList[i].image.toString()),
                    title: Text(taskList[i].title.toString()),
                    subtitle: Text(taskList[i].description.toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (FirebaseAuth.instance.currentUser!.uid ==
                            taskList[i].userID.toString())
                          CupertinoSwitch(
                              value: taskList[i].isCompleted!,
                              onChanged: (val) {
                                TaskServices().markTaskAdComplete(
                                    taskList[i].docId.toString());
                              }),
                        if (FirebaseAuth.instance.currentUser!.uid ==
                            taskList[i].userID.toString())
                          IconButton(
                              onPressed: () {
                                TaskServices()
                                    .deleteTask(taskList[i].docId.toString());
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        if (FirebaseAuth.instance.currentUser!.uid ==
                            taskList[i].userID.toString())
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateTaskView(
                                              model: taskList[i],
                                            )));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              )),
                      ],
                    ),
                  );
                });
          },
        ));
  }
}
