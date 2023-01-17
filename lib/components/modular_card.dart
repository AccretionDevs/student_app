import 'package:flutter/material.dart';
class ModularResultCard extends StatefulWidget {
  final Map<String, dynamic> params;
  final Function? parentOnPressed;
  const ModularResultCard({
    super.key,
    required this.params,
    this.parentOnPressed,
  });
  @override
  State<ModularResultCard> createState() => _ModularResultCardState();
}

class _ModularResultCardState extends State<ModularResultCard> {
  bool hasTitle = false;
  bool hasCallback = false;
  Map<String, dynamic> params = {};
  Function? parentOnPressed = () => {};
  @override
  void initState() {
    super.initState();
    params = widget.params;
    hasTitle = params['title'] != null;
    hasCallback = params['callback'] != null;
    parentOnPressed = widget.parentOnPressed;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: hasCallback ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  hasTitle
                      ? Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text(
                                params['title'].toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.025,
                              ),
                            ],
                          ),
                        )
                      : Text(''),
                  for (List<String> param in params['items'])
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(param[0] + ":", style: TextStyle(fontSize: 12.0)),
                        Text(param[1], style: const TextStyle(fontSize: 18.0)),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ));
  }

  void onPressed() {
    print("Pressed");
    if(hasCallback){
      parentOnPressed!();
    }
  }
}
