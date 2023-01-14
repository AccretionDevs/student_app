import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  String registrationNumber = "";
  String password = "";
  bool rememberPassword = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
                alignment: Alignment.topCenter,
                scale: 7),
          ),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(children: [
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.35,
                        right: 35,
                        left: 35),
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              registrationNumber = value;
                            });
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'Registration Number',
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Quicksand',
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Quicksand',
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(children: [
                          Checkbox(
                            value: rememberPassword,
                            onChanged: (bool? rememberPassword) {
                              setState(() {
                                this.rememberPassword =
                                    rememberPassword ?? true;
                              });
                            },
                          ),
                          const Text('Remember Password')
                        ]),
                        Container(
                          // width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 15),
                          child: Align(
                              alignment: Alignment.center,
                              child: isLoading
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              const EdgeInsets.only(
                                                  left: 60,
                                                  right: 60,
                                                  top: 25,
                                                  bottom: 25)),
                                          backgroundColor: MaterialStateProperty.all(
                                              Colors.blue[400]),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(
                                                      10.0),
                                                  side: const BorderSide(
                                                      color: Colors.grey)))),
                                      onPressed: isLoading
                                          ? null
                                          : () async {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              try {
                                                await login(registrationNumber,
                                                    password, rememberPassword);
                                                if (mounted) {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const HomePage()));
                                                }
                                              } catch (error) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(error
                                                            .toString()
                                                            .substring(11))));
                                              } finally {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              }
                                            },
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )),
                        ),
                      ],
                    ),
                  ),
                )
              ])),
        ));
  }
}

Future<http.Response> login(String re, String ps, bool rp) async {
  try {
    if (re.isEmpty) {
      throw Exception("Please Enter Registration Number");
    }
    if (ps.isEmpty) {
      throw Exception("Please Enter Password");
    }

    Uri url = Uri.parse('https://android.nitsri.ac.in/api/v2/initial/auth');
    Map<String, String> data = {"username": re, "password": ps};
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
    Map<String, dynamic> responseMap = jsonDecode(response.body);

    if (responseCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('form_re', re);
      await prefs.setString('form_ps', ps);
      await prefs.setBool('form_rp', rp);
      await prefs.setBool('is_logged', true);
      await prefs.setString('token', responseMap["UserInfo"]["Token"]);
      await prefs.setString('name', responseMap["UserInfo"]["UserName"]);
      await prefs.setString('regno', responseMap["UserInfo"]["RegNo"]);
      await prefs.setString('enroll', responseMap["UserInfo"]["EnrollmentNo"]);
      await prefs.setString('uano', responseMap["UserInfo"]["UaNo"]);
      await prefs.setString('hfid', responseMap["UserInfo"]["IdNo"]);
      await prefs.setString('branch', responseMap["UserInfo"]["BranchName"]);
      await prefs.setString(
          'semester', responseMap["UserInfo"]["SemesterName"]);
      // await prefs.setString('name', responseMap["UserInfo"]["UserName"]);
      // await prefs.setString('name', responseMap["UserInfo"]["UserName"]);
      // await prefs.setString('name', responseMap["UserInfo"]["UserName"]);
      // await prefs.setString('name', responseMap["UserInfo"]["UserName"]);
      // await prefs.setString('name', responseMap["UserInfo"]["UserName"]);
      // await prefs.setString('name', responseMap["UserInfo"]["UserName"]);
      return response;
    } else {
      throw Exception("Invalid Username or Password");
    }
  } catch (error) {
    rethrow;
  }
}
