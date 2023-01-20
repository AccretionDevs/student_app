import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchData() async {
  // await Future.delayed(const Duration(milliseconds: 1000));

  final prefs = await SharedPreferences.getInstance();

  final token = prefs.getString('token') ?? "NA";
  // final regno = prefs.getString('regno') ?? "NA";
  // final enroll = prefs.getString('enroll') ?? "NA";
  final uatype = prefs.getString('uatype') ?? "NA";
  final uano = prefs.getString('uano') ?? "NA";
  // final hfid = prefs.getString('hfid') ?? "NA";

  Uri urlImage =
      Uri.parse('https://android.nitsri.ac.in/api/v2/information/img');
  Map<String, String> headersImage = {
    "uatype": uatype,
    "id": uano,
    "token": token,
    "Content-Type": "application/x-www-form-urlencoded",
    "Host": "android.nitsri.ac.in",
    "Connection": "Keep-Alive",
    "Accept-Encoding": "gzip",
    "User-Agent": "okhttp/5.0.0-alpha.2"
  };
  Map<String, String> dataImage = {"id": uano};
  String dataImageLen = Uri(queryParameters: dataImage).query.length.toString();
  headersImage["Content-Length"] = dataImageLen;
  final responseImage =
      http.post(urlImage, body: dataImage, headers: headersImage);

  // Uri urlInfo = Uri.parse('https://android.nitsri.ac.in/api/v2/information/stud');
  // Uri urlResultInt = Uri.parse('https://android.nitsri.ac.in/api/v2/exam/int');
  // Uri urlResultExt = Uri.parse('https://android.nitsri.ac.in/api/v2/exam/ext');
  // Uri urlFees = Uri.parse('https://android.nitsri.ac.in/api/v2/fees/paid');

  await responseImage
      .then((response) async => {
            if (response.statusCode == 200)
              {await prefs.setString('image_info', response.body)},
          })
      .catchError((error) => {
            {true}
          });
}
