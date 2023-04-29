import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_record/controllers/student_controller.dart';
import 'package:student_record/helpers/dialogue_helper.dart';
import 'package:student_record/views/student_display.dart';
import 'package:student_record/views/add_student.dart';
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddStudentWidget(isUpdate: false));
          },
        ),
        appBar: !controller.isSearching.value
            ? AppBar(
                title: Text('Home'),
                actions: [
                  IconButton(
                    onPressed: () {
                      controller.isSearching.toggle();
                    },
                    icon: Icon(Icons.search),
                  )
                ],
              )
            : PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: SafeArea(
                    child: TextField(
                      onChanged: (value) async {
                        await controller.searchList(value);
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.isSearching.toggle();
                            },
                            icon: Icon(Icons.close)),
                        border: OutlineInputBorder(),
                        hintText: 'Search Here....',
                      ),
                    ),
                  ),
                ),
              ),
        body: controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final studentData = controller.studentList[index];
                  return InkWell(
                    onTap: () {
                      Get.to(StudentDetailsDisplay(data: studentData));
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        backgroundImage:
                            MemoryImage(base64Decode(studentData.studentImage)),
                      ),
                      title: Text('${studentData.studentName}'),
                      trailing: IconButton(
                        onPressed: () {
                          print(studentData.id);
                          DialogHelper.deleteAlert(
                              context, studentData.id!, controller);
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: controller.studentList.length,
              ),
      ),
    );
  }
}
