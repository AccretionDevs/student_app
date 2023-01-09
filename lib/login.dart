import 'package:flutter/material.dart';
import 'dart:developer';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  String registrationNumber = "";
  String password = "";
  bool rememberPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          decoration: const BoxDecoration(
            color: Colors.white,
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
                              child: ElevatedButton(
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
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            side: const BorderSide(
                                                color: Colors.grey)))),
                                onPressed: () {
                                  login(registrationNumber, password,
                                      rememberPassword);
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

int login(String re, String ps, bool rp) {
  log('re: $re');
  log('ps: $ps');
  log('Rp :$rp');
  return 1;
}
