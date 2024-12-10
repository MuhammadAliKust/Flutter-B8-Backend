import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b8_backend/models/task.dart';
import 'package:flutter_b8_backend/services/task.dart';
import 'package:flutter_b8_backend/views/create_task.dart';
import 'package:flutter_b8_backend/views/update_task.dart';
import 'package:provider/provider.dart';

class GetAllTaskView extends StatelessWidget {
  const GetAllTaskView({super.key});

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
          value: TaskServices().getAllTasks(),
          initialData: [TaskModel()],
          builder: (context, child) {
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    leading: const Icon(Icons.task),
                    title: Text(taskList[i].title.toString()),
                    subtitle: Text(taskList[i].description.toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CupertinoSwitch(
                            value: taskList[i].isCompleted!,
                            onChanged: (val) {
                              TaskServices().markTaskAdComplete(
                                  taskList[i].docId.toString());
                            }),
                        IconButton(
                            onPressed: () {
                              TaskServices()
                                  .deleteTask(taskList[i].docId.toString());
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
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
