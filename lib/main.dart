import 'package:dev_flutter/Home_Page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Magno',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home_Page());
  }
}
