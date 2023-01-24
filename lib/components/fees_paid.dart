import 'package:flutter/material.dart';
import 'package:student_app/components/modular_card.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/components/Upper.dart';

class FeesPaid extends StatefulWidget {
  const FeesPaid({Key? key}) : super(key: key);

  @override
  State<FeesPaid> createState() => _FeesPaidState();
}

class _FeesPaidState extends State<FeesPaid> {
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

          final feesInfoJson = prefs?.getString('fees_info') ?? "{}";

          Map<String, dynamic> json = jsonDecode(feesInfoJson);
          List<Map<String, dynamic>> fee_list = [];

          int len = json['FeesDetails'].length;

          for (int i = 0; i < len; i++) {

            List<dynamic> fee_details_list = [];

            int sem_len = json['FeesDetails']?[i]?['DetailList']?.length ?? 0;
            print(sem_len);
            for(int j = 0; j < sem_len; j++){
              // print(json['FeesDetails']?[i]?['DetailList'][j]?['Key']?.toString() ?? "-");
              fee_details_list.add([
                json['FeesDetails']?[i]?['DetailList'][j]?['Key']?.toString() ?? "-",
                json['FeesDetails']?[i]?['DetailList'][j]?['Value']?.toString() ?? "-"
              ]);
            }
            Map<String, dynamic> fee_map = {
              "items": fee_details_list,
            };
            fee_list.add(fee_map);
            print(fee_list);
          }
          // print(fee_list);
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Upper(
                    title: "Fees Paid",
                    back: false,
                  ),
                  for (int i = 0; i < len; i++)
                    ModularResultCard(params: fee_list[i])
                ],
              ),
            ),
          );
        });
  }
}
