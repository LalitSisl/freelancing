import 'package:flutter/material.dart';
import 'package:freelancing/Authentication/welcome.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.red,
        
        fontFamily: "Ubuntu"
      ),
      home: const Welcome(),
    );
  }
}
