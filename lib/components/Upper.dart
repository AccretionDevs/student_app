import 'package:flutter/material.dart';
import 'package:student_app/home.dart';
import 'package:student_app/splash.dart';

class Upper extends StatefulWidget {
  final String title;
  final bool back;

  const Upper({super.key, required this.title, required this.back});
  @override
  State<Upper> createState() => _UpperState();
}

class _UpperState extends State<Upper> {
  String title = "";
  bool back = false;
  @override
  void initState() {
    super.initState();

    back = widget.back;
    title = widget.title;
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
            // onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'Settings',
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                  ),
                ),
                PopupMenuItem<String>(
                  onTap: () => {
                    // prefs?.setBool('is_logged', false),
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SplashScreen()))
                  },
                  value: 'Logout',
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
  }
}
