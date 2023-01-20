import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'functions/login.dart';
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
    fetchState();
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

  Future<void> fetchState() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final prefs = await SharedPreferences.getInstance();
    final isLogged = prefs.getBool('is_logged');
    final formRe = prefs.getString('form_re');
    final formPs = prefs.getString('form_ps');
    final formRp = prefs.getBool('form_rp');

    bool notLogged = isLogged == null || isLogged == false;
    notLogged = notLogged || formRe == null || formRe.isEmpty;
    notLogged = notLogged || formPs == null || formPs.isEmpty;
    notLogged = notLogged || formRp == null;

    if (notLogged) {
      if (mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MyLogin()));
      }
      return;
    }

    try {
      await doLogin(formRe, formPs, formRp);
      if (mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString().substring(11))));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MyLogin()));
      }
    }
  }
}
