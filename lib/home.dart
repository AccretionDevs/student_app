import 'package:flutter/material.dart';
import 'package:student_app/components/home_component.dart';
import 'package:student_app/components/footer.dart';
import 'package:student_app/components/result_component.dart';
import 'package:student_app/components/info_component.dart';
import 'package:student_app/components/fees_paid.dart';

import 'functions/fetch.dart';

class HomePage extends StatefulWidget {
  final int selectedIndex;

  const HomePage({Key? key, this.selectedIndex = 0}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
            future: loadState(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(snapshot.error.toString().substring(11))));
              }

              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: SafeArea(
                    child: Scaffold(
                      body: selectedIndex == 0
                          ? const HomePageComponent()
                          : selectedIndex == 1
                              ? const ResultComponent()
                              : selectedIndex == 2
                                  ? const InfoComponent()
                                  : selectedIndex == 3
                                      ? const FeesPaid()
                                      : Footer(
                                          selectedIndex: 2, onPressed: _onTap),
                      bottomNavigationBar: Footer(
                          selectedIndex: selectedIndex, onPressed: _onTap),
                    ),
                  ));
            }),
      ),
    );
  }

  Future<String> loadState() async {
    if (isLoading) {
      await fetchData();
      isLoading = false;
    }
    return "Success";
  }

  void _onTap(int i) {
    setState(() {
      selectedIndex = i;
    });
  }
}
