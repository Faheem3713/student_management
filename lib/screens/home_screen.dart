// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:student_record/db/functions/db_function.dart';
import 'package:student_record/db/model/data_model.dart';
import 'package:student_record/screens/widgets/add_student_widget.dart';
import 'package:student_record/screens/widgets/list_student_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearching = false;
  List<StudentModel> _studentList = [];
  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text('Home')
            : TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: 'Search Here....',
                    hintStyle: TextStyle(color: Colors.white)),
              ),
        actions: [
          isSearching
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                    });
                  },
                  icon: Icon(Icons.cancel),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                  icon: Icon(Icons.search),
                ),
        ],
      ),
      body: ListView(
        children: [
          AddStudentWidget(isUpdate: false),
          Expanded(
            child: ListStudentWidget(),
          ),
        ],
      ),
    );
  }

  filterSearchResults(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _studentList = stundentListNotifier.value;
      });
      log(_studentList.length.toString());
    } else {
      _studentList = stundentListNotifier.value
          .where((element) =>
              element.studentName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      log(_studentList.length.toString());
      setState(() {});
    }
  }
}
 