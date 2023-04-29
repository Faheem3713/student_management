import 'dart:developer';
import 'package:get/state_manager.dart';
import 'package:student_record/model/data_model.dart';
import 'package:student_record/services/db_function.dart';

class StudentController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchStudentData();
  }

  List<StudentModel> studentListDemo = <StudentModel>[];
  RxList<StudentModel> studentList = <StudentModel>[].obs;
  var isLoading = true.obs;
  RxBool isSearching = false.obs;

  fetchStudentData() async {
    try {
      isLoading(true);
      
      var _studentList = await DbServices.instance.getAllStudents();
      await Future.delayed(Duration(seconds: 1));
      studentListDemo = List.from(_studentList);
      studentList.value = List.from(_studentList);
    } finally {
      isLoading(false);
    }
  }

  addData(StudentModel studentData) async {
    await DbServices.instance.addStudent(studentData);
    fetchStudentData();
  }

  deleteData(int id) async {
    await DbServices.instance.deleteStudent(id);
    await fetchStudentData();
  }

  updateData(StudentModel studentData) async {
    await DbServices.instance.update(studentData);
    fetchStudentData();
  }

  searchList(String val) {
    if (val.isEmpty) {
      studentList.clear();
      studentList.addAll(studentListDemo);
    } else {
      studentList.clear();
      print(studentListDemo.length);
      studentListDemo.forEach((element) {
        log(val);
        if (element.studentName.toLowerCase().contains(val.toLowerCase())) {
          studentList.add(element);
        }
      });
    }
  }
}
