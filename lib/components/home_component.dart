import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../splash.dart';

void main() {
  runApp(const HomePageComponent());
}

class HomePageComponent extends StatefulWidget {
  const HomePageComponent({Key? key}) : super(key: key);

  @override
  State<HomePageComponent> createState() => _HomePageComponentState();
}

class _HomePageComponentState extends State<HomePageComponent> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
            body: SingleChildScrollView(
              child: Column(
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
                          backgroundImage: AssetImage('assets/images/logo.png'),
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
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 26,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 4.0),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 20, right: 20),
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
                            Text(branch!,
                                style: const TextStyle(fontSize: 18.0)),
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
                            Text(semester!,
                                style: const TextStyle(fontSize: 18.0)),
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
                            ElevatedButton(
                                onPressed: () => {
                                      prefs?.setBool('is_logged', false),
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SplashScreen()))
                                    },
                                child: const Text("Logout"))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
