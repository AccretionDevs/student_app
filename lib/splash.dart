import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'login.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final prefs = await SharedPreferences.getInstance();
    final isLogged = prefs.getBool('is_logged');
    final formRe = prefs.getString('form_re');
    final formPs = prefs.getString('form_ps');

    if (isLogged == null ||
        isLogged == false ||
        formRe == null ||
        formRe.isEmpty ||
        formPs == null ||
        formPs.isEmpty) {
      if (mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MyLogin()));
      }
    }

    try {
      if (formRe == null || formRe.isEmpty) {
        throw Exception("Please Enter Registration Number");
      }
      if (formPs == null || formPs.isEmpty) {
        throw Exception("Please Enter Password");
      }
      Uri url = Uri.parse('https://android.nitsri.ac.in/api/v2/initial/auth');
      Map<String, String> data = {"username": formRe, "password": formPs};
      String dataLen = Uri(queryParameters: data).query.length.toString();
      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "Content-Length": dataLen,
        "Host": "android.nitsri.ac.in",
        "Connection": "Keep-Alive",
        "Accept-Encoding": "gzip",
        "User-Agent": "okhttp/5.0.0-alpha.2"
      };

      final response = await http.post(url, body: data, headers: headers);
      int responseCode = response.statusCode;
      Map<String, dynamic> responseMap = jsonDecode(response.body);

      if (responseCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('form_re', formRe);
        await prefs.setString('form_ps', formPs);
        // await prefs.setBool('form_rp', rp);
        await prefs.setBool('is_logged', true);
        await prefs.setString('token', responseMap["UserInfo"]["Token"]);
        await prefs.setString('name', responseMap["UserInfo"]["UserName"]);
        await prefs.setString('regno', responseMap["UserInfo"]["RegNo"]);
        await prefs.setString(
            'enroll', responseMap["UserInfo"]["EnrollmentNo"]);
        await prefs.setString('uano', responseMap["UserInfo"]["UaNo"]);
        await prefs.setString('hfid', responseMap["UserInfo"]["IdNo"]);
        await prefs.setString('branch', responseMap["UserInfo"]["BranchName"]);
        await prefs.setString(
            'semester', responseMap["UserInfo"]["SemesterName"]);
        // await prefs.setString('name', responseMap["UserInfo"]["UserName"]);
        // await prefs.setString('name', responseMap["UserInfo"]["UserName"]);
        // await prefs.setString('name', responseMap["UserInfo"]["UserName"]);
        // await prefs.setString('name', responseMap["UserInfo"]["UserName"]);
        // await prefs.setString('name', responseMap["UserInfo"]["UserName"]);
        // await prefs.setString('name', responseMap["UserInfo"]["UserName"]);
        // return response;
        if (mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        }
      } else {
        throw Exception("Invalid Username or Password");
      }
    } catch (error) {
      rethrow;
    }

    // await Future.delayed(const Duration(seconds: 2));
    // // Perform network call or any other async task here
    // if (mounted) {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => const MyLogin()));
    // }
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
