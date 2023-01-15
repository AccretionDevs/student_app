import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final int _xyz = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: FutureBuilder(
                future: fetchState(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text(snapshot.error.toString().substring(11))));
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyLogin()));
                  }

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
                })));
  }

  Future<String> fetchState() async {
    await Future.delayed(const Duration(seconds: 1));
    return "Success";
  }
}
