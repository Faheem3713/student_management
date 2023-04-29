import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:student_record/model/data_model.dart';

class DbServices {
  DbServices._privateConstructor();
  static final DbServices instance = DbServices._privateConstructor();

  late Database _db;
  Future<void> initalizeDataBase() async {
    _db = await openDatabase('student.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE student(id INTEGER PRIMARY KEY, name TEXT, age TEXT, class TEXT, number TEXT,image TEXT)');
    });
  }

  Future<List<StudentModel>> getAllStudents() async {
    final _values = await _db.rawQuery('SELECT * FROM student');
    List<StudentModel> studentData = [];
    _values.forEach((map) {
      final student = StudentModel.fromMap(map);
      studentData.add(student);
    });
    return studentData;
  }

  Future<void> addStudent(StudentModel value) async {
    await _db.rawQuery(
        'INSERT INTO student(name,age,class,number,image) VALUES (?,?,?,?,?)', [
      value.studentName,
      value.studentAge,
      value.studentClass,
      value.studentContactNum,
      value.studentImage,
    ]);
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
  }

  Future<void> deleteStudent(int id) async {
    print(id);
    try {
      await _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
    } catch (e) {
      log(e.toString());
    }
  }
}
