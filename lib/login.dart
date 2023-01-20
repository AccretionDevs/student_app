import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  late String registrationNumber;
  late String password;
  late bool rememberPassword;
  late TextEditingController regnoController;
  late TextEditingController passController;

  bool isLoading = true;
  bool isLogging = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
            future: loadState(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(snapshot.error.toString().substring(11))));
              }

              return Scaffold(
                  appBar: null,
                  body: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1),
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
                                  top:
                                      MediaQuery.of(context).size.height * 0.35,
                                  right: 35,
                                  left: 35),
                              child: Column(
                                children: [
                                  TextField(
                                    controller: regnoController,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                    controller: passController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      labelText: 'Password',
                                      labelStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Quicksand',
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
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
                                        child: isLogging
                                            ? const CircularProgressIndicator()
                                            : ElevatedButton(
                                                style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty.all(
                                                            const EdgeInsets.only(
                                                                left: 60,
                                                                right: 60,
                                                                top: 25,
                                                                bottom: 25)),
                                                    backgroundColor:
                                                        MaterialStateProperty.all(
                                                            Colors.blue[400]),
                                                    shape: MaterialStateProperty.all<
                                                            RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10.0),
                                                            side: const BorderSide(color: Colors.grey)))),
                                                onPressed: isLogging
                                                    ? null
                                                    : () async {
                                                        setState(() {
                                                          isLogging = true;
                                                        });
                                                        try {
                                                          await doLogin(
                                                              registrationNumber,
                                                              password,
                                                              rememberPassword);
                                                          if (mounted) {
                                                            Navigator
                                                                .pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            const HomePage(
                                                                              selectedIndex: 0,
                                                                            )));
                                                          }
                                                        } catch (error) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(error
                                                                      .toString()
                                                                      .substring(
                                                                          11))));
                                                        } finally {
                                                          setState(() {
                                                            isLogging = false;
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
            }),
      ),
    );
  }

  Future<String> loadState() async {
    if (isLoading) {
      // await Future.delayed(const Duration(milliseconds: 500));

      final prefs = await SharedPreferences.getInstance();
      final formRe = prefs.getString('form_re') ?? "";
      final formPs = prefs.getString('form_ps') ?? "";
      final formRp = prefs.getBool('form_rp') ?? true;

      registrationNumber = formRe;
      password = formRp ? formPs : "";
      rememberPassword = formRp;

      regnoController = TextEditingController(text: registrationNumber);
      regnoController.addListener(() {
        setState(() {
          registrationNumber = regnoController.text;
        });
      });

      passController = TextEditingController(text: password);
      passController.addListener(() {
        setState(() {
          password = passController.text;
        });
      });

      isLoading = false;
    }

    return "Success";
  }

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
    Map<String, dynamic> responseMap = jsonDecode(response.body);

    if (responseCode == 200) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('form_re', formRe);
      await prefs.setString('form_ps', formPs);
      await prefs.setBool('form_rp', formRp);
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
    } else {
      throw Exception("Invalid Registration Number or Password!");
    }
  }
}
