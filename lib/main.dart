import 'package:flutter/material.dart';
import 'package:student_app/login.dart';
import 'splash.dart';
void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash',
        routes: {'splash': (context) => SplashScreen()},
      ));
}
