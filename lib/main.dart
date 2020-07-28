import 'package:flutter/material.dart';
import 'login.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'Register.dart';
import 'list_reminder.dart';


String mainer;
String mainers;

void main() {
  runApp(MaterialApp(
    home: App(),
    theme: ThemeData(primaryColor: Colors.green, fontFamily: "SourceSansPro"),
    debugShowCheckedModeBanner: false,
    routes: <String, WidgetBuilder>{
      '/HomeScreen': (BuildContext context) =>
          droid == "" ? new HomeScreen() : NoteList(langid: droid,name: droids,)
    },
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  startTime() async {
    _read();
    _reader();
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.fromLTRB(20, 60, 20, 40),
      color: Colors.green,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage("img/white.png"),
            fit: BoxFit.cover,
          ),
          Text(
            "Your Nurse",
            style: TextStyle(
                fontFamily: "SourceSansPro",
                color: Colors.white,
                fontSize: 40.0),
          ),
          Text(
            "In Your Own Hand !!",
            style: TextStyle(
                fontFamily: "SourceSansPro",
                color: Colors.white,
                fontSize: 40.0),
          )
        ],
      ),
    ));
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    final value = prefs.getString(key) ?? "";
    setState(() {
      droid = value;
    });
    print('read: $value');
  }

  _reader() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_String_key';
    final value = prefs.getString(key) ?? "";
    setState(() {
      droids = value;
    });
    print('read: $value');
  }
}
