// import 'package:api_intigration/get_api_screen.dart';
import 'package:flutter/material.dart';
import 'get_api_example.dart';
import 'get_api_with_custom_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GetApiExampleThree(), // Another example with get api with nested array model
      // GetApiWithCustomModel(), //get api example with custom model withOut plugin
      // const GetApiHome(), get api first example
    );
  }
}
