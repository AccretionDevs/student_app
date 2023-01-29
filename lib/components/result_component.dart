import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_app/components/modular_card.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/components/Upper.dart';

class ResultComponent extends StatefulWidget {
  const ResultComponent({Key? key}) : super(key: key);

  @override
  State<ResultComponent> createState() => _ResultComponentState();
}

class _ResultComponentState extends State<ResultComponent> {
  bool showResult = false;
  int sem = -1;
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
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final prefs = snapshot.data;
          final resInfoJsonExtern = prefs?.getString('res_ext') ?? "{}";
          final resInfoJsonIntern = prefs?.getString('res_int') ?? "{}";

          List<dynamic> json_external = jsonDecode(resInfoJsonExtern);
          List<dynamic> json_internal = jsonDecode(resInfoJsonIntern);

          int len_extern = json_external.length;
          Map<String, List<String>> external_marks = {};
          List<dynamic> result_list = [];
          int temp = 0;
          for (int i = 0; i < len_extern; i++) {
            int pr_ind = json_external[i]['Result'].length - 1 ?? 0;
            Map<String, dynamic> result_map = {
              "title": "Autumn 2022",
              "items": [
                ["Semester", (i + 1).toString()],
                ["SGPA", json_external[i]?['Result']?[0]?['Value']?.toString() ?? "-"],
                if(i != 0)
                  ["CGPA", json_external[i]?['Result']?[1]?['Value']?.toString() ?? "-"],
                if(i == 0)
                  ["CGPA", json_external[i]?['Result']?[0]?['Value']?.toString() ?? "-"],
                ["Provisional Result", json_external[i]?['Result']?[pr_ind]?['Value']?.toString() ?? "-"],
              ],
              "callback": true
            };
            result_list.add(result_map);
            for(int j = 0; j < json_external[i]?['ExternalMarks']?.length; j++){
              external_marks[json_external[i]?['ExternalMarks']?[j]?['CourseName']?.toString()??"-"] = [(json_external[i]?['ExternalMarks']?[j]?['Grade']?.toString() ?? "-"), (json_external[i]?['ExternalMarks']?[j]?['Credits']?.toString() ?? "-")];
            }
            temp = i;
          }
          int remaining_sem =json_internal.length - len_extern;
          for(int i = temp;  i < remaining_sem + temp; i++){
            int pr_ind = json_external[i]?['Result']?.length - 1 ?? 0;
            Map<String, dynamic> result_map = {
              "title": "Autumn 2022",
              "items": [
                ["Semester", (i + 1).toString()],
                ["SGPA", json_external[i]?['Result']?[0]?['Value']?.toString() ?? "-"],
                ["CGPA", json_external[i]?['Result']?[1]?['Value']?.toString() ?? "-"],
                ["Provisional Result", json_external[i]?['Result']?[pr_ind]?['Value']?.toString() ?? "-"],
              ],
              "callback": true
            };
            result_list.add(result_map);
            for(int j = 0; j < json_external[i]?['ExternalMarks'].length; j++){
              external_marks[json_external[i]?['ExternalMarks']?[j]?['CourseName']?.toString()??"-"] = [(json_external[i]?['ExternalMarks']?[j]?['Grade']?.toString() ?? "-"), (json_external[i]?['ExternalMarks']?[j]?['Credits']?.toString() ?? "-")];
            }
          }

          List<List<Map<String, dynamic>>> internal_list = [];

          for (int i = 0; i < json_internal.length ; i++) {
            int subjects = json_internal[i]['InternalMarks'].length ?? 0;
            List<Map<String, dynamic>> result_list_temp = [];

            for(int j = 0; j < subjects; j++){
              bool isLab = json_internal[i]['InternalMarks'][j]['S1Max'].toString() == '0';

              Map<String, dynamic> result_map = {
                "title": json_internal[i]['InternalMarks'][j]['CourseName'],
                "items": [
                  ["Semester", (i + 1).toString()],
                ],
              };
              if(!isLab){
                result_map["items"].add(["Internal", "${json_internal[i]?['InternalMarks']?[j]?['S1Obt']?.toString() ?? "-"} / ${json_internal[i]['InternalMarks'][j]['S1Max'].toString()}"]);
                result_map["items"].add(["Mid Term", "${json_internal[i]?['InternalMarks']?[j]?['S2Obt']?.toString() ?? "-"} / ${json_internal[i]['InternalMarks'][j]['S2Max'].toString()}"]);
              }
              else{
                result_map["items"].add(["Internal", "${json_internal[i]?['InternalMarks']?[j]?['S3Obt']?.toString() ?? "-"} / ${json_internal[i]['InternalMarks'][j]['S3Max'].toString()}"]);
              }
              result_map["items"].add(["Grade", external_marks[(json_internal[i]?['InternalMarks']?[j]?['CourseName'])?.toString()]?[0].toString() ?? "-"]);
              result_map["items"].add(["Credits", external_marks[(json_internal[i]?['InternalMarks']?[j]?['CourseName'])?.toString()]?[1].toString() ?? "-"]);
              result_list_temp.add(result_map);
            }
            internal_list.add(result_list_temp);
          }

    return showResult
        ? Container(
            child: Scaffold(
              appBar: AppBar(
                  flexibleSpace: Upper(
                title: result_list[sem]["title"],
                back: true,
              )),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    for (int itemx = 0; itemx < internal_list[sem].length; itemx++)
                      ModularResultCard(params: internal_list[sem][itemx])
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
                  for (int item = 0; item < result_list.length; item++)
                    ModularResultCard(
                        params: result_list[item],
                        parentOnPressed: () {
                          pressedSem(item);
                        })
                ],
              ),
            ));
        });
  }

  void pressedSem(int ind) {
    log('Pressed inside result component: $ind');
    setState(() {
      showResult = true;

      sem = ind;
    });
  }
}
