import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('Loading...'),
                );
              }

              final prefs = snapshot.data;
              // final token = prefs?.getString('token');
              final name = prefs?.getString('name');
              final regno = prefs?.getString('regno');
              final enroll = prefs?.getString('enroll');
              // final uano = prefs?.getString('uano');
              // final hfid = prefs?.getString('hfid');
              final branch = prefs?.getString('branch');
              final semester = prefs?.getString('semester');
              // final name = prefs?.getString('name');

              return Scaffold(
                body: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.13,
                          ),
                          const CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                AssetImage('assets/images/logo.png'),
                            backgroundColor: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                      name!.toUpperCase(),
                      style: const TextStyle(
                        // color: Colors.grey,
                        fontFamily: 'Quicksand',
                        fontSize: 26,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Card(
                      // margin: EdgeInsets.symmetric(horizontal: 4, vertical: 40.0),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 20, right: 180),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text("Registration Number:",
                                style: TextStyle(fontSize: 12.0)),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Text(regno!,
                                style: const TextStyle(fontSize: 18.0)),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            const Text("Branch:",
                                style: TextStyle(fontSize: 12.0)),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Text(branch!, style: const TextStyle(fontSize: 18.0)),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            const Text("Enrollment Number:",
                                style: TextStyle(fontSize: 12.0)),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Text(enroll!,
                                style: const TextStyle(fontSize: 18.0)),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            const Text("Semester:",
                                style: TextStyle(fontSize: 12.0)),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Text(semester!, style: const TextStyle(fontSize: 18.0)),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            const Text("CGPA:",
                                style: TextStyle(fontSize: 12.0)),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            const Text("NA", style: TextStyle(fontSize: 18.0)),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.assessment),
                      label: 'Result',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Info',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                  ],
                  iconSize: 35,
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                ),
              );
            }),
      ),
    );
  }
}

void _onItemTapped(int index) {
  log('$index');
}
