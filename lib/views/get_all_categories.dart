import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b8_backend/models/category.dart';
import 'package:flutter_b8_backend/models/task.dart';
import 'package:flutter_b8_backend/services/category.dart';
import 'package:flutter_b8_backend/services/task.dart';
import 'package:flutter_b8_backend/views/create_task.dart';
import 'package:flutter_b8_backend/views/get_category_task.dart';
import 'package:flutter_b8_backend/views/update_task.dart';
import 'package:provider/provider.dart';

class GetAllCategoriesView extends StatelessWidget {
  const GetAllCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Get All Categories"),
        ),
        body: StreamProvider.value(
          value: CategoryServices().getAllCategories(),
          initialData: [CategoryModel()],
          builder: (context, child) {
            List<CategoryModel> categoryList =
                context.watch<List<CategoryModel>>();
            return Container(
              height: 140,
              child: ListView.builder(
                  itemCount: categoryList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GetCategoryTaskView(
                                      categoryID:
                                          categoryList[i].docId.toString())));
                        },
                        child: Container(
                          color: Colors.blue.withOpacity(0.5),
                          height: 100,
                          width: 100,
                          child: Text(categoryList[i].name.toString()),
                        ),
                      ),
                    );
                  }),
            );
          },
        ));
  }
}
