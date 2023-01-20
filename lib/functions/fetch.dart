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

  // Uri urlResultInt = Uri.parse('https://android.nitsri.ac.in/api/v2/exam/int');
  // Uri urlResultExt = Uri.parse('https://android.nitsri.ac.in/api/v2/exam/ext');

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
}
