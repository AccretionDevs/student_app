import 'package:flutter/material.dart';
import 'package:student_app/components/modular_card.dart';
import 'dart:developer';
import 'package:student_app/components/Upper.dart';

class ResultComponent extends StatefulWidget {
  const ResultComponent({Key? key}) : super(key: key);

  @override
  State<ResultComponent> createState() => _ResultComponentState();
}

class _ResultComponentState extends State<ResultComponent> {
  bool showResult = false;
  int sem = -1;

  List<Map<String, dynamic>> res = [
    {
      "title": "Autumn 2022",
      "items": [
        ["Semester", "1"],
        ["CGPA", "8.92"],
        ["SGPA", "3"],
        ["CGPA", "8.92"]
      ],
      "callback": true
    },
    {
      "title": "Summer 2023",
      "items": [
        ["Semester", "2"],
        ["CGPA", "8.92"],
        ["SGPA", "3"],
        ["CGPA", "8.92"]
      ],
      "callback": true
    }
  ];
  List<List<Map<String, dynamic>>> inter = [
    [
      {
        "title": "database management systems",
        "items": [
          ["Semester", "1"],
          ["Grade", "A"],
          ["Credits", "3"],
          ["Internal", "20"]
        ],
        // "callback": true
      },
      {
        "title": "Operating Systems",
        "items": [
          ["Semester", "1"],
          ["Grade", "B+"],
          ["Credits", "4"],
          ["Internal", "15"]
        ]
      }
    ],
    [
      {
        "title": "database management systems",
        "items": [
          ["Semester", "2"],
          ["Grade", "A"],
          ["Credits", "3"],
          ["Internal", "20"]
        ],
        // "callback": true
      },
      {
        "title": "Operating Systems",
        "items": [
          ["Semester", "2"],
          ["Grade", "B+"],
          ["Credits", "4"],
          ["Internal", "15"]
        ]
      }
    ],
    [
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
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return showResult
        ? Container(
            child: Scaffold(
              appBar: AppBar(
                  flexibleSpace: Upper(
                title: '${res[sem]["title"]}',
                back: true,
                    popback:(){
                  pressedSem(-1);
                    },
              )),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    for (int itemx = 0; itemx < inter[sem].length; itemx++)
                      ModularResultCard(params: inter[sem][itemx])
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
                flexibleSpace: Upper(
              title: 'Result',
              back: false,
            )),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  for (int item = 0; item < res.length; item++)
                    ModularResultCard(
                        params: res[item],
                        parentOnPressed: () {
                          pressedSem(item);
                        })
                ],
              ),
            ));
  }

   pressedSem(int ind) {
    log('Pressed inside result component: $ind');
    setState(() {
      showResult = !showResult;

      sem = ind;
    });
  }
}
