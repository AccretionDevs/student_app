import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  final int selectedIndex;
  final Function onPressed;
  const Footer(
      {super.key, required this.selectedIndex, required this.onPressed});
  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int selectedIndex = 0;
  Function onPressed = () => {};
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
    onPressed = widget.onPressed;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
        currentIndex: selectedIndex,
        onTap: (int i) => {
              setState(() {
                selectedIndex = i;
              }),
              onPressed(i)
            });
  }
}
