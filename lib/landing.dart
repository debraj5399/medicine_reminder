import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:notification_alarm_example/main.dart';
import 'Register.dart';
import 'list_reminder.dart';
import 'list_reminder.dart';

class Lang extends StatefulWidget {
  final String name;
  Lang({
    this.name,
  });
  @override
  _LangState createState() => _LangState();
}

class _LangState extends State<Lang> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          color: Colors.green,
          child: ListView(
            children: <Widget>[
              Divider(
                color: Colors.transparent,
                height: 5.0,
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  "Select\nYour Language !!",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "SourceSansPro",
                      fontSize: 40.0),
                ),
              ),
              Divider(
                color: Colors.transparent,
                height: 40.0,
              ),
              GradientButton(
                child: Text(
                  'English',
                  style: TextStyle(fontFamily: "SourceSansPro", fontSize: 20.0),
                ),
                callback: () {
                  setState(() {
                    mainer = "en";
                  });
                  save();

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NoteList(
                            name: widget.name,
                            langid: "en",
                          )));
                },
                increaseHeightBy: 18.0,
                increaseWidthBy: 70.0,
                gradient: Gradients.rainbowBlue,
              ),
              Divider(
                color: Colors.transparent,
                height: 50.0,
              ),
              GradientButton(
                child: Text(
                  'हिंदी',
                  style: TextStyle(fontFamily: "SourceSansPro", fontSize: 20.0),
                ),
                callback: () {
                  setState(() {
                    mainer = "hi";
                  });
                  save();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NoteList(
                            name: widget.name,
                            langid: "hi",
                          )));
                },
                increaseHeightBy: 18.0,
                increaseWidthBy: 70.0,
                gradient: Gradients.rainbowBlue,
              ),
              Divider(
                color: Colors.transparent,
                height: 50.0,
              ),
              GradientButton(
                child: Text(
                  'मराठी',
                  style: TextStyle(fontFamily: "SourceSansPro", fontSize: 20.0),
                ),
                callback: () {
                  setState(() {
                    mainer = "mr";
                  });
                  save();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NoteList(
                            name: widget.name,
                            langid: "mr",
                          )));
                },
                increaseHeightBy: 18.0,
                increaseWidthBy: 70.0,
                gradient: Gradients.rainbowBlue,
              ),
              Divider(
                color: Colors.transparent,
                height: 60.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Selecting Language",
                    style: TextStyle(
                      fontFamily: "SourceSansPro",
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 5.0,
                  ),
                  Text(
                    "Will be the default language for your App",
                    style: TextStyle(
                      fontFamily: "SourceSansPro",
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 5.0,
                  ),
                  Text(
                    "Thankyou !!",
                    style: TextStyle(
                      fontFamily: "SourceSansPro",
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  //willpop_back button controller
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            backgroundColor: Colors.green,
            title: new Text(
              areyousure,
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: "SourceSansPro",
                color: Colors.white,
              ),
            ),
            content: new Text(
              doyouwanttoexit,
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: "SourceSansPro",
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  no,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "SourceSansPro",
                    color: Colors.white,
                  ),
                ),
              ),
              new FlatButton(
                onPressed: () => exit(0),
                child: new Text(
                  yes,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "SourceSansPro",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  //sharedprefrences
  _save() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    final value = mainer;
    setState(() {
      droid = value;
    });
    prefs.setString(key, value);
    print('saved $value');
  }

  void save() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    prefs.setString(key, mainer);
    _save();
  }
}
