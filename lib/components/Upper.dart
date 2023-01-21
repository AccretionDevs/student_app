import 'package:flutter/material.dart';
import 'package:student_app/home.dart';
import 'package:student_app/splash.dart';

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
      title: Container(
        margin: ((back == true)
            ? EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03)
            : EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.11)),
        child: Text(
          '${title}',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
      actions: <Widget>[
        PopupMenuButton<String>(
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
      ],
    );
  }
}
