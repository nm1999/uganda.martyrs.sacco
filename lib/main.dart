import 'package:flutter/material.dart';
import 'package:ugandamartyrssacco/splashscreen.dart';
import 'package:get/get.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initstate() {
    Timer(Duration(seconds: 3), () {
      Get.to(Splashscreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: Splashscreen());
  }
}
