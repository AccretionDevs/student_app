import 'package:flutter/material.dart';
import 'package:student_app/login.dart';

void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {'login': (context) => const MyLogin()},
      ));
}
