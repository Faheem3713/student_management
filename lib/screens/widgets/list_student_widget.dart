import 'dart:convert';
import 'package:flutter/material.dart';
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
                    deleteAlert(context, data);
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

  void deleteAlert(BuildContext context, StudentModel data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text('Are you sure you want to delete'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                deleteStudent(data.id!);
                Navigator.pop(context);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
