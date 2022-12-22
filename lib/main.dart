import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_record/db/functions/db_function.dart';
import 'package:student_record/db/model/data_model.dart';
import 'package:student_record/screens/home_screen.dart';
import 'package:student_record/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initalizeDataBase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primary_color,
      ),
      home: HomeScreen(),
    );
  }
}
