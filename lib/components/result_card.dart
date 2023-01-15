import 'package:flutter/material.dart';
import 'dart:developer';

class ResultCard extends StatefulWidget {
  final String session, semester, sgpa, cgpa;
  final Function pressedSem;
  const ResultCard(
      {super.key,
      required this.session,
      required this.semester,
      required this.sgpa,
      required this.cgpa,
      required this.pressedSem});
  @override
  State<ResultCard> createState() => _ResultCardState();
}
class _ResultCardState extends State<ResultCard> {
  String session = '';
  String semester = '';
  String sgpa = '';
  String cgpa = '';
  Function pressedSem = () => {};
  @override
  void initState() {
    super.initState();
    session = widget.session;
    semester = widget.semester;
    sgpa = widget.sgpa;
    cgpa = widget.cgpa;
    pressedSem = widget.pressedSem;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      session,
                      style: const TextStyle(
                        fontSize: 30,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  const Text("Semester:", style: TextStyle(fontSize: 12.0)),
                  Text(semester, style: const TextStyle(fontSize: 18.0)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const Text("SGPA:", style: TextStyle(fontSize: 12.0)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(sgpa, style: const TextStyle(fontSize: 18.0)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const Text("CGPA:", style: TextStyle(fontSize: 12.0)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(cgpa, style: const TextStyle(fontSize: 18.0)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ],
              ),
            ),
          ),
        ));
  }

  void onPressed() {
    log('Pressed');
    log(semester);
    pressedSem(semester);
  }
}
