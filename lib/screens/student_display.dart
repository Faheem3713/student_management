import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:student_record/db/functions/db_function.dart';
import 'package:student_record/db/model/data_model.dart';
import 'package:student_record/screens/widgets/add_student_widget.dart';
import 'package:student_record/screens/widgets/student_table.dart';

class StudentDetailsDisplay extends StatelessWidget {
  final StudentModel data;
  // final Text studentName;
  // final Text studentAge;
  // final Text studentClass;
  // final Text studentNum;

  const StudentDetailsDisplay({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // final _id = this.id;
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => Scaffold(
                              appBar: AppBar(title: Text('Update')),
                              body: ListView(children: [
                                AddStudentWidget(isUpdate: true, student: data),
                              ]),
                            )));
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: MemoryImage(base64Decode(data.studentImage)),
            ),
            ValueListenableBuilder(
              valueListenable: stundentListNotifier,
              builder: (BuildContext ctx, List<StudentModel> studentList,
                  Widget? child) {
                return StudentTableWidget(
                    stName: tableText(data.studentName),
                    stAge: tableText(data.studentAge),
                    stClass: tableText(data.studentClass),
                    stNum: tableText(data.studentContactNum));
              },
            ),
          ],
        ),
      ),
    );
  }
}

Text tableText(String input) {
  return Text(
    input,
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  );
}
