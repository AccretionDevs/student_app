import 'package:flutter/material.dart';
import 'package:student_app/components/home_component.dart';
import 'package:student_app/components/footer.dart';
import 'package:student_app/components/result_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Homepage'),
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: handleClick,
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
                        value: 'Logout',
                        child: ListTile(
                          leading: Icon(Icons.exit_to_app),
                          title: Text("Logout"),
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),
            body: _selectedIndex == 0
                ? const HomePageComponent()
                : _selectedIndex == 1
                    ? const ResultComponent()
                    : Footer(selectedIndex: 2, onPressed: _onTap),
            bottomNavigationBar:
                Footer(selectedIndex: _selectedIndex, onPressed: _onTap),
          ),
        ));
  }
  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }
  void _onTap(int i) {
    setState(() {
      _selectedIndex = i;
    });
  }
}
