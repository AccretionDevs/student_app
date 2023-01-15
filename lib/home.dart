import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'package:student_app/components/home_component.dart';
import 'package:student_app/components/footer.dart';
void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _selectedIndex == 0 ? HomePageComponent(): Footer(selectedIndex: 2, onPressed: _onTap),
        bottomNavigationBar: Footer(selectedIndex: _selectedIndex, onPressed: _onTap),
      ),
    );
  }
  void _onTap(int i) {
    setState(() {
      _selectedIndex = i;
    });
  }
}

