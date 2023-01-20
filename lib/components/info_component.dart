import 'package:flutter/material.dart';
import 'package:student_app/components/modular_card.dart';

class InfoComponent extends StatefulWidget {
  const InfoComponent({Key? key}) : super(key: key);

  @override
  State<InfoComponent> createState() => _InfoComponentState();
}

class _InfoComponentState extends State<InfoComponent> {
  int item = 0;
  int i = 0;
  pageChanged(int t) {
    setState(() {
      item = t;
    });
  }

  PageController _controller = PageController(
    initialPage: 0,
  );

  String title = "Studnet Inormation";
  List<Map<String, dynamic>> res = [
    {
      "title": "Personal",
      "items": [
        ["NAME", "YASIR"],
        ["ADRESS", "KASHMIR"],
        ["ENROLLMENT", "50"],
        ["DEGREE", "B-TECH"]
      ],
      // "callback": true
    },
    {
      "title": "Contact",
      "items": [
        ["NAME", "YASIR"],
        ["ADRESS", "KASHMIR"],
        ["ENROLLMENT", "50"],
        ["DEGREE", "B-TECH"]
      ],
      // "callback": true
    },
    {
      "title": "Postal",
      "items": [
        ["NAME", "YASIR"],
        ["ADRESS", "KASHMIR"],
        ["ENROLLMENT", "50"],
        ["DEGREE", "B-TECH"]
      ],
      // "callback": true
    },
    {
      "title": "Subject",
      "items": [
        ["NAME", "YASIR"],
        ["ADRESS", "KASHMIR"],
        ["ENROLLMENT", "50"],
        ["DEGREE", "B-TECH"]
      ],
      // "callback": true
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 20,
        foregroundColor: Colors.black54,
        automaticallyImplyLeading: false,
        title: Container(
          margin:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.11),
          child: Text(
            '${title}',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
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
      body: Column(
        children: [
          // PageIndicator(currentValue: item,),
          buildBottomNav(),

          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (value) {
                pageChanged(value);
              },
              children: [
                for (i = 0; i < 4; i++)
                  ModularResultCard(
                    params: res[i],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomNav() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            4,
            (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: AnimatedContainer(
                    curve: Curves.easeInCubic,
                    duration: const Duration(milliseconds: 500),
                    width: 100,
                    height: 20,
                    child: index == 0
                        ? GestureDetector(
                            onTap: () {
                              _controller.animateToPage(0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            },
                            child: Center(child: Text("Personal")))
                        : index == 1
                            ? GestureDetector(
                                onTap: () {
                                  _controller.animateToPage(1,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeIn);
                                },
                                child: Center(child: Text("Conatct")))
                            : index == 2
                                ? GestureDetector(
                                    onTap: () {
                                      _controller.animateToPage(2,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeIn);
                                    },
                                    child: Center(child: Text("Postal")))
                                : index == 3
                                    ? GestureDetector(
                                        onTap: () {
                                          _controller.animateToPage(3,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.easeIn);
                                        },
                                        child: Center(child: Text("Subject")))
                                    : Center(child: Text("")),
                    decoration: BoxDecoration(
                      color: item == index ? Colors.grey : Colors.white54,
                      // borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                )),
      ),
    );
  }
}
