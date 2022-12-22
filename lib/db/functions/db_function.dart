import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_record/db/model/data_model.dart';

ValueNotifier<List<StudentModel>> stundentListNotifier = ValueNotifier([]);

late Database _db;

Future<void> getAllStudents() async {
  // final studentDB = await Hive.openBox<StudentModel>('student_db');

  final _values = await _db.rawQuery('SELECT * FROM student');
  print(_values);
  print('Happiness');
  stundentListNotifier.value.clear();

  _values.forEach((map) {
    final student = StudentModel.fromMap(map);
    stundentListNotifier.value.add(student);
    stundentListNotifier.notifyListeners();
  });
}

Future<void> initalizeDataBase() async {
  _db = await openDatabase('student.db', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE student(id INTEGER PRIMARY KEY, name TEXT, age TEXT, class TEXT, number TEXT,image TEXT)');
  });
}

Future<void> addStudent(StudentModel value) async {
  // final studentDB = await Hive.openBox<StudentModel>('student_db');

  // final _id = await studentDB.add(value);
  // value.id = _id;
  log(value.toString());
  await _db.rawQuery(
      'INSERT INTO student(name,age,class,number,image) VALUES (?,?,?,?,?)', [
    value.studentName,
    value.studentAge,
    value.studentClass,
    value.studentContactNum,
    value.studentImage,
  ]);
  getAllStudents();
}

Future<void> update(StudentModel val) async {
  Map<String, Object?> row = {
    'id': val.id,
    'name': val.studentName,
    'age': val.studentAge,
    'class': val.studentClass,
    'number': val.studentContactNum,
    'image': val.studentImage
  };

  await _db.update('student', row, where: 'id = ?', whereArgs: [val.id]);
  // log(row.toString());
  await getAllStudents();
}

Future<void> deleteStudent(int id) async {
  _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
  getAllStudents();
  stundentListNotifier.notifyListeners();
}
