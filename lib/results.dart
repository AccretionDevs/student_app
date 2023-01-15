import 'dart:html';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/components/footer.dart';
import 'dart:developer';

import 'package:student_app/home.dart';
import 'package:student_app/home.dart';
class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              return Scaffold(
              body:
                  Container(
                      child: ElevatedButton(
                        child: Text('hello'),
                        onPressed: () => {
                          setState(() {
                            this._selectedIndex = this._selectedIndex+1;
                          }),
                          log(this._selectedIndex.toString())
                        },
                      )
                  ),
                bottomNavigationBar: _selectedIndex == 0 ? Footer(selectedIndex: 0, onButtonPressed: _handleButtonPress): Footer(selectedIndex: 1, ),
              );
            },
          ),
        ));
  }
}

void _onItemTapped(int index, BuildContext context) {
  if(index == 0){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
            const HomePage()));
  }
  log('$index');
}