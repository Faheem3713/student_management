import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_record/views/student_display.dart';

class StudentTableWidget extends StatelessWidget {
  final String stName;
  final String stAge;
  final String stClass;
  final String stNum;

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
                  TableRow(children: [
                    tableText('Name'),
                    Text(
                      stName,
                      textAlign: TextAlign.center,
                    )
                  ]),
                  TableRow(children: [
                    tableText('Age'),
                    Text(
                      stAge,
                      textAlign: TextAlign.center,
                    )
                  ]),
                  TableRow(children: [
                    tableText('Age'),
                    Text(
                      stClass,
                      textAlign: TextAlign.center,
                    )
                  ]),
                  TableRow(children: [
                    tableText('Class'),
                    Text(
                      stNum,
                      textAlign: TextAlign.center,
                    )
                  ]),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
