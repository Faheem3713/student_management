import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:student_record/services/db_function.dart';
import 'package:student_record/views/widgets/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbServices.instance.initalizeDataBase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: HomeScreen(),
    );
  }
}
