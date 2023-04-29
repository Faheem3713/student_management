import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_record/controllers/student_controller.dart';

class DialogHelper {
  static void deleteAlert(
      BuildContext context, int id, StudentController controller) {
    Get.defaultDialog(
      title: 'Delete',
      content: Text('Are you sure you want to delete'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('No'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();
            controller.deleteData(id);
          },
          child: Text('Yes'),
        ),
      ],
    );
  }
}
