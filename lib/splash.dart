import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'login.dart';
import 'package:student_app/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    // Perform network call or any other async task here
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyLogin()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/logo.png'),
              alignment: Alignment.center,
              scale: 5),
        ),
            // CircularProgressIndicator(),

      ),
    );
  }
}

