import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:student_record/db/functions/db_function.dart';
import 'package:student_record/db/model/data_model.dart';
import 'package:student_record/screens/student_display.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: stundentListNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return ListView.separated(
          shrinkWrap: true,
          reverse: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final data = studentList[index];

            return InkWell(
              onTap: () {
                // Navigator.of(context).push('');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StudentDetailsDisplay(data: data)),
                );
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  backgroundImage: MemoryImage(base64Decode(data.studentImage)),
                ),
                title: Text('Name : ${data.studentName}'),
                trailing: IconButton(
                  onPressed: () {
                    if (data.id != null) {
                      deleteStudent(data.id!);
                    } else {
                      print('Student id is null');
                    }
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
          itemCount: studentList.length,
        );
      },
    );
  }
}
