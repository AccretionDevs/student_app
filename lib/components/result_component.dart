import 'package:flutter/material.dart';
import 'package:student_app/components/modular_card.dart';
import 'dart:developer';

class ResultComponent extends StatefulWidget {
  const ResultComponent({Key? key}) : super(key: key);

  @override
  State<ResultComponent> createState() => _ResultComponentState();
}

class _ResultComponentState extends State<ResultComponent> {
  bool showResult = false;
  int index = -1;
  // Map<String, Function> myMap = {"callback": () => pressedSem()};
  List<Map<String, dynamic>> m3 = [
    {
      "title": "Autumn 2022",
      "items": [
        ["Semester", "3"],
        ["CGPA", "8.92"],
        ["SGPA", "3"],
        ["CGPA", "8.92"]
      ],
      "callback": true
    },
    {
      "items": [
        ["Semester", "3"],
        ["CGPA", "8.92"],
        ["SGPA", "3"],
        ["CGPA", "8.92"]
      ]
    }
  ];
  List<Map<String, dynamic>> m4 = [
    {
      "title": "database management systems",
      "items": [
        ["Semester", "3"],
        ["Grade", "A"],
        ["Credits", "3"],
        ["Internal", "20"]
      ],
      // "callback": true
    },
    {
      "title": "Operating Systems",
      "items": [
        ["Semester", "3"],
        ["Grade", "B+"],
        ["Credits", "4"],
        ["Internal", "15"]
      ]
    }
  ];
  @override
  Widget build(BuildContext context) {
    return (SingleChildScrollView(
      child: Column(
        children: <Widget>[
          for(int item = 0; item < m3.length; item++)
              ModularResultCard(params: m3[item], parentOnPressed: () {pressedSem(item);})
        ],
      ),
    ));
  }
  void pressedSem(int ind) {
    log('Pressed inside result component: $ind');
    setState(() {
      showResult=true;
      index = ind;
    });
    // log('$ind');
    // log(sem);
  }
}
