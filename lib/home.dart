import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Screen',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Student Dairy'),
        ),
        body: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('Loading...'),
                );
              }

              final prefs = snapshot.data;
              final name = prefs?.getString('name');

              return Center(
                child: Text(
                  'Welcome to Student Dairy, $name',
                ),
              );
            }),
        // body: const Center(
        //   child: Text('Welcome to Student Dairy'),
        // ),
      ),
    );
  }
}
