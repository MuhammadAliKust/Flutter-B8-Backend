import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b8_backend/models/category.dart';
import 'package:flutter_b8_backend/models/task.dart';
import 'package:flutter_b8_backend/services/category.dart';
import 'package:flutter_b8_backend/services/task.dart';
import 'package:flutter_b8_backend/services/upload_file_services.dart';
import 'package:flutter_b8_backend/views/get_all_task.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CreateTaskView extends StatefulWidget {
  CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;

  File? image;
  List<CategoryModel> categoriesList = [];
  CategoryModel? _selectedCategory;

  getCategories() {
    CategoryServices().getAllCategories().first.then((val) {
      categoriesList = val;
      setState(() {});
    });
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create Task"),
        ),
        body: Column(
          children: [
            InkWell(
              onTap: () {
                ImagePicker()
                    .pickImage(source: ImageSource.gallery)
                    .then((filePath) {
                  image = File(filePath!.path);
                  setState(() {});
                });
              },
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10)),
                child: image == null
                    ? Center(
                        child: Icon(Icons.upload),
                      )
                    : Image.file(
                        image!,
                        height: 150,
                      ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButton(
                items: categoriesList.map((e) {
                  return DropdownMenuItem(
                    child: Text(
                      e.name.toString(),
                    ),
                    value: e,
                  );
                }).toList(),
                value: _selectedCategory,
                onChanged: (val) {
                  _selectedCategory = val;
                  setState(() {});
                }),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: titleController,
            ),
            TextFormField(
              controller: descriptionController,
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (titleController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Title cannot be empty")));
                    return;
                  }
                  if (descriptionController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Description cannot be empty")));
                    return;
                  }
                  try {
                    isLoading = true;
                    setState(() {});
                    await UploadFileServices()
                        .getUrl(image)
                        .then((downloadUrl) async {
                      await TaskServices()
                          .createTask(TaskModel(
                              title: titleController.text,
                              description: descriptionController.text,
                              isCompleted: false,
                              image: downloadUrl,
                              categoryID: _selectedCategory!.docId.toString(),
                              userID: FirebaseAuth.instance.currentUser!.uid,
                              createdAt: DateTime.now().millisecondsSinceEpoch))
                          .then((val) {
                        isLoading = false;
                        setState(() {});
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Message"),
                                content:
                                    Text("Task has been created successfully"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GetAllTaskView()));
                                      },
                                      child: Text("Okay"))
                                ],
                              );
                            });
                      });
                    });
                  } catch (e) {
                    isLoading = false;
                    setState(() {});
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                child: Text("Create Task"))
          ],
        ),
      ),
    );
  }
}
