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

  String title = "Studnet Information";
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
                for (i = 0; i < 2; i++)
                  ModularResultCard(
                    params: res[i],
                  ),
                postal(),
                subject(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  //widget for postal details
  Widget postal(){
    return SingleChildScrollView(
      child: Column(
        children: [
          ModularResultCard(
            params: res[2],
          ),
          ModularResultCard(
            params: res[2],
          ),

        ],
      ),
    );
  }
  // widget for subject details
 Widget subject(){
    return SingleChildScrollView(
      child: Column(
        children: [
          for(int i =0;i<4;i++)
            ModularResultCard(
              params: res[i],
            ),
        ],
      ),
    );
 }
  Widget heading() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            4,
            (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal:13 ),
                  child: AnimatedContainer(
                    curve: Curves.easeInCubic,
                    duration: const Duration(milliseconds: 500),
                    width: 90,
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
                      border: Border(

                        bottom:item ==  index ? BorderSide(
                            width: 3.0,
                                color: Colors.black54,
                        ):BorderSide(width: 0,color:Colors.transparent,),
                      ),
                      color:  Colors.white54,
                      // borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                )),
      ),
    );
  }
}
