import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller_binder.dart';
import 'home_screen.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomeScreen(),
      initialBinding: ControllerBinder(),
    );
  }
}
