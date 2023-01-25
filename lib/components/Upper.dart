import 'package:flutter/material.dart';
import 'package:student_app/home.dart';
import 'package:student_app/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Upper extends StatefulWidget {
  final String title;
  final bool back;
  final prefs;

  const Upper(
      {super.key, required this.title, required this.back, this.prefs = null});
  @override
  State<Upper> createState() => _UpperState();
}

class _UpperState extends State<Upper> {
  String title = "";
  bool back = false;
  var prefs;
  @override
  void initState() {
    super.initState();

    back = widget.back;
    title = widget.title;
    prefs = widget.prefs;
  }

  @override
  Widget build(BuildContext context) {
   return  FutureBuilder(
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
    // final imageInfoJson = prefs?.getString('image_info') ?? "{}";
    Map<String, dynamic> loginInfo = jsonDecode(loginInfoJson);
    // Map<String, dynamic> imageInfo = jsonDecode(imageInfoJson);

    // final regno = loginInfo["UserInfo"]?["RegNo"] ?? "NA";
    // final enroll = loginInfo["UserInfo"]?["EnrollmentNo"] ?? "NA";
    // final name = loginInfo["UserInfo"]?["UserName"] ?? "NA";
    // final branch = loginInfo["UserInfo"]?["BranchName"] ?? "NA";
    // final semester = loginInfo["UserInfo"]?["SemesterName"] ?? "NA";
    // final baseImage = imageInfo["Photo"] ??
    "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";

    // log("login_info" + (prefs?.getString('login_info') ?? "NA"));
    // // log("image_info" + (prefs?.getString('image_info') ?? "NA"));
    // log("student_info" + (prefs?.getString('student_info') ?? "NA"));
    // log("fees_info" + (prefs?.getString('fees_info') ?? "NA"));

    return AppBar(
      backgroundColor: Colors.white,
      bottomOpacity: 20,
      foregroundColor: Colors.black54,
      automaticallyImplyLeading: false,
      leading: (back == true)
          ? IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                  selectedIndex: 1,
                )),
          );
        },
      )
          : null,
      centerTitle: true,
      title: Container(

        child: Text(
          '${title}',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ),

      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.035,),
          child: PopupMenuButton<String>(
            onSelected: (result) {
              if (result == 'settings') {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Settings!!!")));
              } else if (result == 'logout') {

                  prefs?.setBool('is_logged', false);

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SplashScreen()));
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'settings',
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text("Logout"),
                  ),
                ),
              ];
            },
          ),
        ),
      ],
    );
    });
  }
}
