// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_record/db/functions/db_function.dart';
import 'package:student_record/db/model/data_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_record/screens/home_screen.dart';

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
  File? selectedImage;
  var img;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            child: selectedImage != null
                ? TextButton(
                    onPressed: () async {
                      _getFromGallery();
                    },
                    child: Image.file(selectedImage!))
                : TextButton.icon(
                    label: Text(''),
                    onPressed: () async {
                      _getFromGallery();
                    },
                    icon: Icon(Icons.add)),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _studentName,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Name'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _studentAge,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Age'),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _studentClass,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Course'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _studentContactNum,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Contact Number'),
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                onAddStundentButton();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: ((context) => HomeScreen())),
                    (route) => false);
              },
              child: Text('Add'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onAddStundentButton() async {
    final _name = _studentName.text.trim();
    final _age = _studentAge.text.trim();
    final _class = _studentClass.text.trim();
    final _number = _studentContactNum.text.trim();

    if (_name.isEmpty ||
        _age.isEmpty ||
        _class.isEmpty ||
        _number.isEmpty ||
        img == null) {
      // log(_name.toString());
      // log(_age.toString());
      // log(_class.toString());
      // log(_number.toString());
      // log(img.toString());
      return;
    }

    //  log('$_name $_age $_class $img');

    final _student = StudentModel(
      studentImage: img,
      studentName: _name,
      studentAge: _age,
      studentClass: _class,
      studentContactNum: _number,
    );
    log(widget.isUpdate.toString());
    widget.isUpdate == true
        ? await update(StudentModel(
            id: widget.student!.id,
            studentImage: img,
            studentName: _name,
            studentAge: _age,
            studentClass: _class,
            studentContactNum: _number,
          ))
        : await addStudent(_student);
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
