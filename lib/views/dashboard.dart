import 'package:flutter/material.dart';
import 'package:flutter_b8_backend/models/task.dart';
import 'package:flutter_b8_backend/services/task.dart';
import 'package:flutter_b8_backend/views/get_all_task.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GetAllTaskView()));
        },
        child: Icon(Icons.add),
      ),
      body: StreamProvider.value(
          value: TaskServices().getAllTasks(''),
          initialData: [TaskModel()],
          builder: (context, child) {
            List<TaskModel> allTaskList = context.watch<List<TaskModel>>();
            return StreamProvider.value(
                value: TaskServices().getCompletedTasks(),
                initialData: [TaskModel()],
                builder: (context, child) {
                  List<TaskModel> completedTaskList =
                      context.watch<List<TaskModel>>();
                  return StreamProvider.value(
                      value: TaskServices().getInCompletedTasks(),
                      initialData: [TaskModel()],
                      builder: (context, child) {
                        List<TaskModel> inCompletedTaskList =
                            context.watch<List<TaskModel>>();
                        return Column(
                          children: [
                            Text(
                              'Total Tasks: ${allTaskList.length}',
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(
                              'Completed Tasks: ${completedTaskList.length}',
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(
                              'InCompleted Tasks: ${inCompletedTaskList.length}',
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        );
                      });
                });
          }),
    );
  }
}
