import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> doLogin(String formRe, String formPs, bool formRp) async {
  Uri url = Uri.parse('https://android.nitsri.ac.in/api/v2/initial/auth');
  Map<String, String> data = {"username": formRe, "password": formPs};
  String dataLen = Uri(queryParameters: data).query.length.toString();
  Map<String, String> headers = {
    "Content-Type": "application/x-www-form-urlencoded",
    "Content-Length": dataLen,
    "Host": "android.nitsri.ac.in",
    "Connection": "Keep-Alive",
    "Accept-Encoding": "gzip",
    "User-Agent": "okhttp/5.0.0-alpha.2"
  };

  final response = await http.post(url, body: data, headers: headers);
  int responseCode = response.statusCode;
  String responseJson = response.body;
  Map<String, dynamic> responseMap = jsonDecode(responseJson);

  if (responseCode == 200) {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('form_re', formRe);
    await prefs.setString('form_ps', formPs);
    await prefs.setBool('form_rp', formRp);
    await prefs.setBool('is_logged', true);

    await prefs.setString('token', responseMap["UserInfo"]["Token"]);
    await prefs.setString('regno', responseMap["UserInfo"]["RegNo"]);
    await prefs.setString('enroll', responseMap["UserInfo"]["EnrollmentNo"]);
    await prefs.setString('uatype', responseMap["UserInfo"]["UaType"]);
    await prefs.setString('uano', responseMap["UserInfo"]["UaNo"]);
    await prefs.setString('hfid', responseMap["UserInfo"]["IdNo"]);

    await prefs.setString('login_info', responseJson);
  } else {
    throw Exception("Invalid Registration Number or Password!");
  }
}
