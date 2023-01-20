import 'package:flutter/material.dart';
import 'package:student_app/components/modular_card.dart';

import 'package:student_app/components/Upper.dart';

class FeesPaid extends StatefulWidget {
  const FeesPaid({Key? key}) : super(key: key);

  @override
  State<FeesPaid> createState() => _FeesPaidState();
}

class _FeesPaidState extends State<FeesPaid> {
  List<Map<String, dynamic>> fee = [
    {
      "title": "Autumn 2022",
      "items": [
        ["Session", "1"],
        ["Amount", "10000"],
        ["Reciept No.", "01"],
        ["Date", "dd/mm/yyyy"],
        ["Fee Type", "Tution Fee"]
      ],
    },
    {
      "title": "Autumn 2022",
      "items": [
        ["Session", "1"],
        ["Amount", "10000"],
        ["Reciept No.", "01"],
        ["Date", "dd/mm/yyyy"],
        ["Fee Type", "Tution Fee"]
      ],
    },
    {
      "title": "Autumn 2022",
      "items": [
        ["Session", "1"],
        ["Amount", "10000"],
        ["Reciept No.", "01"],
        ["Date", "dd/mm/yyyy"],
        ["Fee Type", "Tution Fee"]
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Upper(
              title: "Fees Paid",
              back: false,
            ),
            for (int itemx = 0; itemx < fee.length; itemx++)
              ModularResultCard(params: fee[itemx])
          ],
        ),
      ),
    );
  }
}
