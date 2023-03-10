import 'package:flutter/material.dart';
import 'package:student_app/components/modular_card.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/components/Upper.dart';

class InfoComponent extends StatefulWidget {
  const InfoComponent({Key? key}) : super(key: key);

  @override
  State<InfoComponent> createState() => _InfoComponentState();
}

class _InfoComponentState extends State<InfoComponent> {
  int item = 0;
  int i = 0;
  ScrollController control_heading = ScrollController();
  pageChanged(int t) {
    setState(() {
      item = t;
      control_heading.animateTo(
        (item * 10).toDouble(),
        duration: Duration(milliseconds: 150),
        curve: Curves.easeInCubic,
      );
    });
  }

  PageController _controller = PageController(
    initialPage: 0,
  );

  String title = "Student Information";

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
          final StudentInfoJson = prefs?.getString('student_info') ?? "{}";

          Map<String, dynamic> json = jsonDecode(StudentInfoJson);

          int len = json['StudentInfo']?.length ?? 0;
          List<dynamic> info_list = [];
          for (int i = 0; i < len; i++) {
            info_list.add([
              json['StudentInfo']?[i]?['Key']?.toString() ?? "-",
              json['StudentInfo']?[i]?['Value']?.toString() ?? "-"
            ]);
          }
          Map<String, dynamic> personal_details = {
            "title": "Personal Details",
            "items": info_list,
          };

          int len_contact_info = json['ContactInfo']?.length ?? 0;
          List<dynamic> contact_list = [];
          for (int i = 0; i < len_contact_info; i++) {
            contact_list.add([
              json['ContactInfo']?[i]?['Key']?.toString() ?? "-",
              json['ContactInfo']?[i]?['Value']?.toString() ?? "-"
            ]);
          }
          Map<String, dynamic> contact_info = {
            "title": "Contact Details",
            "items": contact_list,
          };

          return Scaffold(
            appBar: AppBar(
              flexibleSpace: Upper(
                title: "Student Information",
                back: false,
              ),
            ),
            body: Column(
              children: [
                // PageIndicator(currentValue: item,),
                heading(),

                Expanded(
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (value) {
                      pageChanged(value);
                    },
                    children: [
                      SingleChildScrollView(
                        child: ModularResultCard(
                          params: personal_details,
                        ),
                      ),

                      SingleChildScrollView(
                        child: ModularResultCard(
                          params: contact_info,
                        ),
                      ),
                      postal(),
                      subject(),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  //widget for postal details
  Widget postal() {
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

          final StudentInfoJson = prefs?.getString('student_info') ?? "{}";

          Map<String, dynamic> json = jsonDecode(StudentInfoJson);

          // PostalInfo
          int len_postal_info = json['PostalInfo']?.length ?? 0;
          List<dynamic> postal_list_perm = [];
          List<dynamic> postal_list_local = [];
          List<dynamic> postal_list_guard = [];

          for (int i = 0; i < len_postal_info; i++) {
            if (json['PostalInfo']?[i]?['Type'] == '3') {
              postal_list_local.add([
                json['PostalInfo']?[i]?['Key']?.toString() ?? "-",
                json['PostalInfo']?[i]?['Value']?.toString() ?? "-"
              ]);
            } else if (json['PostalInfo']?[i]?['Type'] == '4') {
              postal_list_perm.add([
                json['PostalInfo']?[i]?['Key']?.toString() ?? "-",
                json['PostalInfo']?[i]?['Value']?.toString() ?? "-"
              ]);
            } else if (json['PostalInfo']?[i]?['Type'] == '5') {
              postal_list_guard.add([
                json['PostalInfo']?[i]?['Key']?.toString() ?? "-",
                json['PostalInfo']?[i]?['Value']?.toString() ?? "-"
              ]);
            }
          }
          Map<String, dynamic> postal_perm = {
            "title": "Permanent Address",
            "items": postal_list_perm,
          };
          Map<String, dynamic> postal_local = {
            "title": "Local Address",
            "items": postal_list_local,
          };
          Map<String, dynamic> postal_guard = {
            "title": "Guardian Address",
            "items": postal_list_guard,
          };

          return SingleChildScrollView(
            child: Column(
              children: [
                ModularResultCard(
                  params: postal_local,
                ),
                ModularResultCard(
                  params: postal_perm,
                ),
                ModularResultCard(
                  params: postal_guard,
                ),
              ],
            ),
          );
        });
  }

  // widget for subject details
  Widget subject() {
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

          final loginInfoJson = prefs?.getString('login_info') ?? "{}";

          Map<String, dynamic> json = jsonDecode(loginInfoJson) ?? "";
          List<Map<String, dynamic>> courseList = [];

          int len = json['StudentCourse']?.length ?? 0;
          for (int i = 0; i < len; i++) {
            Map<String, dynamic> course = {
              "items": [
                [
                  'Course Name',
                  json['StudentCourse']?[i]?['CourseName']?.toString() ?? "-"
                ],
                [
                  'Course Code',
                  json['StudentCourse']?[i]?['CourseCode']?.toString() ?? "-"
                ],
              ],
            };
            courseList.add(course);
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < len; i++)
                  ModularResultCard(
                    params: courseList[i],
                  ),
              ],
            ),
          );
        });
  }

  Widget heading() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      scrollDirection: Axis.horizontal,
      controller: control_heading,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            4,
            (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: AnimatedContainer(
                    curve: Curves.easeInCubic,
                    duration: const Duration(milliseconds: 150),
                    width: 80,
                    height: 25,
                    child: index == 0
                        ? GestureDetector(
                            onTap: () {
                              _controller.animateToPage(0,
                                  duration: Duration(milliseconds: 150),
                                  curve: Curves.easeIn);
                            },
                            child: Center(
                                child: Text(
                              "Personal",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500),
                            )))
                        : index == 1
                            ? GestureDetector(
                                onTap: () {
                                  _controller.animateToPage(1,
                                      duration: Duration(milliseconds: 150),
                                      curve: Curves.easeIn);
                                },
                                child: Center(
                                    child: Text(
                                  "Contact",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500),
                                )))
                            : index == 2
                                ? GestureDetector(
                                    onTap: () {
                                      _controller.animateToPage(2,
                                          duration: Duration(milliseconds: 150),
                                          curve: Curves.easeIn);
                                    },
                                    child: Center(
                                        child: Text(
                                      "Postal",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500),
                                    )))
                                : index == 3
                                    ? GestureDetector(
                                        onTap: () {
                                          _controller.animateToPage(3,
                                              duration:
                                                  Duration(milliseconds: 150),
                                              curve: Curves.easeIn);
                                        },
                                        child: Center(
                                            child: Text(
                                          "Subjects",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500),
                                        )))
                                    : Center(child: Text("")),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: item == index
                            ? BorderSide(
                                width: 3.0,
                                color: Colors.black54,
                              )
                            : BorderSide(
                                width: 0,
                                color: Colors.transparent,
                              ),
                      ),
                      color: Colors.white54,
                      // borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                )),
      ),
    );
  }
}
