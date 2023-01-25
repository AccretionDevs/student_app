import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<void> fetchData() async {
  // await Future.delayed(const Duration(milliseconds: 1000));

  final prefs = await SharedPreferences.getInstance();

  final token = prefs.getString('token') ?? "NA";
  final regno = prefs.getString('regno') ?? "NA";
  final enroll = prefs.getString('enroll') ?? "NA";
  final uatype = prefs.getString('uatype') ?? "NA";
  final uano = prefs.getString('uano') ?? "NA";
  // final hfid = prefs.getString('hfid') ?? "NA";

  final loginInfoJson = prefs.getString('login_info') ?? "{}";
  Map<String, dynamic> loginInfo = jsonDecode(loginInfoJson);

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

  Uri urlInfo =
      Uri.parse('https://android.nitsri.ac.in/api/v2/information/stud');
  Map<String, String> headersInfo = {
    "uatype": uatype,
    "id": uano,
    "token": token,
    "Content-Type": "application/x-www-form-urlencoded",
    "Host": "android.nitsri.ac.in",
    "Connection": "Keep-Alive",
    "Accept-Encoding": "gzip",
    "User-Agent": "okhttp/5.0.0-alpha.2"
  };
  Map<String, String> dataInfo = {"id": enroll};
  String dataInfoLen = Uri(queryParameters: dataInfo).query.length.toString();
  headersInfo["Content-Length"] = dataInfoLen;
  final responseInfo = http.post(urlInfo, body: dataInfo, headers: headersInfo);

  Uri urlResultInt = Uri.parse('https://android.nitsri.ac.in/api/v2/exam/int');
  Map<String, String> headersResultInt = {
    "uatype": uatype,
    "id": uano,
    "token": token,
    "Content-Type": "application/x-www-form-urlencoded",
    "Host": "android.nitsri.ac.in",
    "Connection": "Keep-Alive",
    "Accept-Encoding": "gzip",
    "User-Agent": "okhttp/5.0.0-alpha.2"
  };
  List<Future<http.Response>> responseResultInt = [];
  for (int i = 0; i < loginInfo["InternalSession"].length; i++) {
    Map<String, String> dataResultInt = {
      "id": enroll,
      "no": loginInfo["InternalSession"]?[i]?["SessionNo"] ?? "0",
      "sem": loginInfo["InternalSession"]?[i]?["SemesterNo"] ?? "0"
    };
    String dataResultIntLen =
        Uri(queryParameters: dataResultInt).query.length.toString();
    headersInfo["Content-Length"] = dataResultIntLen;
    final resp =
        http.post(urlResultInt, body: dataResultInt, headers: headersResultInt);
    responseResultInt.add(resp);
  }

  Uri urlResultExt = Uri.parse('https://android.nitsri.ac.in/api/v2/exam/ext');
  Map<String, String> headersResultExt = {
    "uatype": uatype,
    "id": uano,
    "token": token,
    "Content-Type": "application/x-www-form-urlencoded",
    "Host": "android.nitsri.ac.in",
    "Connection": "Keep-Alive",
    "Accept-Encoding": "gzip",
    "User-Agent": "okhttp/5.0.0-alpha.2"
  };
  List<Future<http.Response>> responseResultExt = [];
  for (int i = 0; i < loginInfo["ExternalSession"].length; i++) {
    Map<String, String> dataResultExt = {
      "id": enroll,
      "no": loginInfo["ExternalSession"]?[i]?["SessionNo"] ?? "0",
      "sem": loginInfo["ExternalSession"]?[i]?["SemesterNo"] ?? "0"
    };
    String dataResultExtLen =
        Uri(queryParameters: dataResultExt).query.length.toString();
    headersInfo["Content-Length"] = dataResultExtLen;
    final resp =
        http.post(urlResultExt, body: dataResultExt, headers: headersResultExt);
    responseResultExt.add(resp);
  }

  Uri urlFees = Uri.parse('https://android.nitsri.ac.in/api/v2/fees/paid');
  Map<String, String> headersFees = {
    "uatype": uatype,
    "id": uano,
    "token": token,
    "Content-Type": "application/x-www-form-urlencoded",
    "Host": "android.nitsri.ac.in",
    "Connection": "Keep-Alive",
    "Accept-Encoding": "gzip",
    "User-Agent": "okhttp/5.0.0-alpha.2"
  };
  Map<String, String> dataFees = {"id": regno};
  String dataFeesLen = Uri(queryParameters: dataFees).query.length.toString();
  headersFees["Content-Length"] = dataFeesLen;
  final responseFees = http.post(urlFees, body: dataFees, headers: headersFees);

  await responseImage
      .then((response) async => {
            if (response.statusCode == 200)
              {await prefs.setString('image_info', response.body)},
          })
      .catchError((error) => {
            {true}
          });
  await responseInfo
      .then((response) async => {
            if (response.statusCode == 200)
              {await prefs.setString('student_info', response.body)},
          })
      .catchError((error) => {
            {true}
          });
  await responseFees
      .then((response) async => {
            if (response.statusCode == 200)
              {await prefs.setString('fees_info', response.body)},
          })
      .catchError((error) => {
            {true}
          });

  List<dynamic> listResultInt = [];
  for (Future<http.Response> resp in responseResultInt) {
    await resp
        .then((response) async => {
              if (response.statusCode == 200)
                {listResultInt.add(jsonDecode(response.body))},
            })
        .catchError((error) => {
              {true}
            });
  }
  await prefs.setString('res_int', jsonEncode(listResultInt));

  List<dynamic> listResultExt = [];
  for (Future<http.Response> resp in responseResultExt) {
    await resp
        .then((response) async => {
              if (response.statusCode == 200)
                {listResultExt.add(jsonDecode(response.body))},
            })
        .catchError((error) => {
              {true}
            });
  }
  await prefs.setString('res_ext', jsonEncode(listResultExt));
}
