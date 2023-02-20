import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_record/screens/student_display.dart';

class StudentTableWidget extends StatelessWidget {
  final Text stName;
  final Text stAge;
  final Text stClass;
  final Text stNum;

  const StudentTableWidget(
      {super.key,
      required this.stName,
      required this.stAge,
      required this.stClass,
      required this.stNum});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Table(
                // border: TableBorder.all(width: 1),
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [tableText('Name'), stName]),
                  TableRow(children: [tableText('Age'), stAge]),
                  TableRow(children: [tableText('Class'), stClass]),
                  TableRow(children: [tableText('Contact Number'), stNum]),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
