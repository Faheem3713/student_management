import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_record/model/data_model.dart';
import 'package:student_record/views/add_student.dart';
import 'package:student_record/views/widgets/student_table.dart';

class StudentDetailsDisplay extends StatelessWidget {
  final StudentModel data;
  const StudentDetailsDisplay({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(AddStudentWidget(isUpdate: true, student: data));
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: MemoryImage(base64Decode(data.studentImage)),
            ),
            StudentTableWidget(
                stName: data.studentName,
                stAge: data.studentAge,
                stClass: data.studentClass,
                stNum: data.studentContactNum)
          ],
        ),
      ),
    );
  }
}

Text tableText(String input) {
  return Text(
    "            $input",
    style: Get.textTheme.titleMedium,
    textAlign: TextAlign.start,
  );
}
