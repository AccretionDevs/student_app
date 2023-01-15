import 'package:flutter/material.dart';
import 'package:student_app/components/result_card.dart';
import 'dart:developer';

class ResultComponent extends StatefulWidget {
  const ResultComponent({Key? key}) : super(key: key);

  @override
  State<ResultComponent> createState() => _ResultComponentState();
}

class _ResultComponentState extends State<ResultComponent> {
  String session = 'AUTUMN 2022';
  String semester = '5';
  String sgpa = '8.923';
  String cgpa = '8.635';
  @override
  Widget build(BuildContext context) {
    return (SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ResultCard(
              session: session,
              semester: semester,
              sgpa: sgpa,
              cgpa: cgpa,
              pressedSem: pressedSem),
          ResultCard(
              session: session,
              semester: semester,
              sgpa: sgpa,
              cgpa: cgpa,
              pressedSem: pressedSem),
          ResultCard(
              session: session,
              semester: semester,
              sgpa: sgpa,
              cgpa: cgpa,
              pressedSem: pressedSem),
          ResultCard(
              session: session,
              semester: semester,
              sgpa: sgpa,
              cgpa: cgpa,
              pressedSem: pressedSem),
          ResultCard(
              session: session,
              semester: semester,
              sgpa: sgpa,
              cgpa: cgpa,
              pressedSem: pressedSem),
        ],
      ),
    ));
  }

  void pressedSem(String sem) {
    log('Pressed inside result component');
    log(sem);
  }
}
