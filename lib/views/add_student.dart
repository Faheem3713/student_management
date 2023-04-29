import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_record/controllers/student_controller.dart';
import 'package:student_record/model/data_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_record/views/widgets/home_screen.dart';

import 'widgets/textfield_widget.dart';

class AddStudentWidget extends StatefulWidget {
  AddStudentWidget({super.key, required this.isUpdate, this.student});
  final bool isUpdate;
  final StudentModel? student;
  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final _studentName = TextEditingController();
  final _studentAge = TextEditingController();
  final _studentClass = TextEditingController();
  final _studentContactNum = TextEditingController();
  final controller = Get.find<StudentController>();
  File? selectedImage;
  var img;
  final _key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _key,
          child: ListView(
            children: [
              Container(
                height: 150,
                width: 150,
                child: widget.isUpdate
                    ? TextButton(
                        onPressed: () async {
                          _getFromGallery();
                        },
                        child: Image.memory(base64Decode(img)))
                    : selectedImage != null
                        ? TextButton(
                            onPressed: () async {
                              _getFromGallery();
                            },
                            child: Image.file(selectedImage!))
                        : TextButton.icon(
                            label: Text(
                              '',
                            ),
                            onPressed: () async {
                              _getFromGallery();
                            },
                            icon: Icon(Icons.add)),
              ),
              CustomTextField(controller: _studentName, text: 'Name'),
              CustomTextField(
                  controller: _studentAge,
                  text: 'Age',
                  type: TextInputType.number),
              CustomTextField(controller: _studentClass, text: 'Course'),
              CustomTextField(
                controller: _studentContactNum,
                text: 'Phone number',
                type: TextInputType.phone,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate() && img != null) {
                      onAddStundentButton();
                      Get.offAll(HomeScreen());
                    }
                  },
                  child: Text('Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onInit() {
    if (widget.isUpdate) {
      _studentName.text = widget.student!.studentName;
      _studentAge.text = widget.student!.studentAge;
      _studentClass.text = widget.student!.studentClass;
      _studentContactNum.text = widget.student!.studentContactNum;
      img = widget.student!.studentImage;
    }
  }

  Future<void> onAddStundentButton() async {
    final _student = StudentModel(
      studentImage: img,
      studentName: _studentName.text.trim(),
      studentAge: _studentAge.text.trim(),
      studentClass: _studentClass.text.trim(),
      studentContactNum: _studentContactNum.text.trim(),
    );
    widget.isUpdate == true
        ? await controller.updateData(StudentModel(
            id: widget.student!.id,
            studentImage: img,
            studentName: _studentName.text.trim(),
            studentAge: _studentAge.text.trim(),
            studentClass: _studentClass.text.trim(),
            studentContactNum: _studentContactNum.text.trim(),
          ))
        : controller.addData(_student);
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      setState(() {
        final val = selectedImage!.readAsBytesSync();
        img = base64Encode(val);
      });
    }
  }
}
