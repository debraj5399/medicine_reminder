import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'landing.dart';
import 'Register.dart';
import 'list_reminder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

//Global
SharedPreferences sharedPreferences;
void clear() async{
  final pref = await SharedPreferences.getInstance();
  await pref.clear();
}

class HomeScreen extends StatefulWidget {
  String user;
  String pass;

  HomeScreen({
    this.user,
    this.pass,
  });
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool checkValue = false;


  _onChanged(bool value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("username", widget.user);
      sharedPreferences.setString("password", widget.pass);
      sharedPreferences.commit();
      getCredential();
    });
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue) {
          username.text = sharedPreferences.getString("username");
          password.text = sharedPreferences.getString("password");
          _navigator();
        } else {
          username.clear();
          password.clear();
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }

  _navigator() async {
    if (username.text.length != 0 || password.text.length != 0) {
      
        Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Lang()));
      
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          child: new AlertDialog(
            backgroundColor: Colors.green,
            content: new Text(
              "Username or Password\nIncorrect !!",
              style: new TextStyle(
                  fontSize: 20.0,
                  fontFamily: "SourceSansPro",
                  color: Colors.white),
            ),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text(
                    "OK",
                    style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "SourceSansPro",
                        color: Colors.white),
                  ))
            ],
          ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getCredential();
  }

  static bool see = false;

  Icon check = Icon(
    Icons.visibility,
    color: Colors.white,
  );
  Icon uncheck = Icon(
    Icons.visibility_off,
    color: Colors.white,
  );

  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              Container(
                child: ClipPath(
                  clipper: WaveClipperTwo(),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.20,
                    color: Colors.green,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                      child: ListView(
                        children: <Widget>[
                          Divider(
                            color: Colors.transparent,
                            height: 10.0,
                          ),

//Logo
                          Container(
                            height: 110.0,
                            child: Image(
                              image: AssetImage(
                                "img/white.png",
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),

                          Divider(
                            color: Colors.transparent,
                            height: 10.0,
                          ),
                          Text(
                            "LOGIN",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "SourceSansPro",
                                fontSize: 38.0),
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 20.0,
                          ),
                          Text(
                            "Username",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "SourceSansPro",
                                fontSize: 20.0),
                          ),
                          TextField(
                            controller: username,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "SourceSansPro",
                                fontSize: 25.0),
                            cursorColor: Colors.white,
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 15.0,
                          ),
                          Text(
                            "Passowrd",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "SourceSansPro",
                                fontSize: 20.0),
                          ),
                          TextFormField(
                            controller: password,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                              icon: see == false ? uncheck : check,
                              onPressed: () {
                                if (see == true) {
                                  setState(() {
                                    see = false;
                                  });
                                } else {
                                  setState(() {
                                    see = true;
                                  });
                                }
                              },
                            )),
                            obscureText: see == false ? true : false,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "SourceSansPro",
                                fontSize: 25.0),
                            cursorColor: Colors.white,
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 5.0,
                          ),
                         
                          Divider(
                            color: Colors.transparent,
                            height: 25.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new InkWell(
                                
                                
                                
                                // onTap: ()
                                // {
                                //   _onChanged(true);
                                // },


                                onTap: () {
                                  if (widget.user == "" ||
                                      widget.pass == "" ||
                                      username.text.isEmpty ||
                                      password.text.isEmpty) {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        child: new AlertDialog(
                                          backgroundColor: Colors.green,
                                          content: new Text(
                                            "You Need to Register with Us !!",
                                            style: new TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: "SourceSansPro",
                                                color: Colors.white),
                                          ),
                                          actions: <Widget>[
                                            new FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Second()));
                                                },
                                                child: new Text(
                                                  "OK",
                                                  style: new TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          "SourceSansPro",
                                                      color: Colors.white),
                                                ))
                                          ],
                                        ));
                                  } else if (username.text == widget.user &&
                                      password.text == widget.pass) {
                                        setState(() {
                                         mainers=username.text; 
                                        });
                                        saver();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Lang(name: widget.user,)));
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        child: new AlertDialog(
                                          backgroundColor: Colors.green,
                                          content: new Text(
                                            "Username or Password\nIncorrect !!",
                                            style: new TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: "SourceSansPro",
                                                color: Colors.white),
                                          ),
                                          actions: <Widget>[
                                            new FlatButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: new Text(
                                                  "OK",
                                                  style: new TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          "SourceSansPro",
                                                      color: Colors.white),
                                                ))
                                          ],
                                        ));
                                  }
                                },
                                child: new Container(
                                    width: 180.0,
                                    height: 40.0,
                                    decoration: new BoxDecoration(
                                      color: Colors.transparent,
                                      border: new Border.all(
                                          color: Colors.white, width: 2.0),
                                      borderRadius:
                                          new BorderRadius.circular(0.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: new Center(
                                        child: new Text(
                                          'LOGIN',
                                          style: new TextStyle(
                                              fontSize: 20.0,
                                              fontFamily: "SourceSansPro",
                                              color: Colors.white),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 30.0),
                    child: FloatingActionButton(
                      elevation: 5.0,
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Second()));
                      },
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  )
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
  ///////////////////////////////////////////////////////////////////////

  _saver() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_String_key';
    final value = mainers;
    setState(() {
      droids = value;
    });
    prefs.setString(key, value);
    print('saved $value');
  }

  void saver() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_String_key';
    prefs.setString(key, mainers);
    _saver();
  }

}
