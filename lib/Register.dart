import 'package:flutter/material.dart';
import 'login.dart';
import 'package:email_validator/email_validator.dart';

String droid = "";
String droids = "";
bool isValid = true;

class Second extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
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
  final lastname = TextEditingController();
  final email = TextEditingController();

  String error;

  void validateEmail() {
    isValid = EmailValidator.validate(email.text);
    print(isValid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.green,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back,color: Colors.white,size: 35.0,),
      //     onPressed: ()
      //     {
      //       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));
      //     },
      //   ),
      //   elevation: 0.0,
      // ),
      body: Container(
          color: Colors.green,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
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
                height: 5.0,
              ),
              Text(
                "REGISTER",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "SourceSansPro",
                    fontSize: 38.0),
              ),
              Divider(
                color: Colors.transparent,
                height: 10.0,
              ),
              Text(
                "First Name",
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
                height: 10.0,
              ),
              Text(
                "Last Name",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "SourceSansPro",
                    fontSize: 20.0),
              ),
              TextField(
                controller: lastname,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "SourceSansPro",
                    fontSize: 25.0),
                cursorColor: Colors.white,
              ),
              Divider(
                color: Colors.transparent,
                height: 10.0,
              ),
              Text(
                "Email",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "SourceSansPro",
                    fontSize: 20.0),
              ),
              TextField(
                onChanged: (bool) {
                  validateEmail();
                },
                controller: email,
                decoration: InputDecoration(
                    errorText: error, errorStyle: TextStyle(color: Colors.red)),
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "SourceSansPro",
                    fontSize: 25.0),
                cursorColor: Colors.white,
              ),
              Divider(
                color: Colors.transparent,
                height: 10.0,
              ),
              Text(
                "Password",
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
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new InkWell(
                    onTap: () {
                      String name = username.text;
                      String lname = lastname.text;
                      String emailer = email.text;
                      String pass = password.text;

                      if (name.length < 3 ||
                          pass.length < 4 ||
                          lname.length < 4 ||
                          emailer.length < 4) {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            child: new AlertDialog(
                              backgroundColor: Colors.green,
                              content: new Text(
                                "You have short entry fields!!",
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
                      } else if (isValid == false) {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            child: new AlertDialog(
                              backgroundColor: Colors.green,
                              content: new Text(
                                "Invalid Email",
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
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen(
                                  user: username.text,
                                  pass: password.text,
                                )));
                      }
                    },
                    child: new Container(
                        width: 180.0,
                        height: 40.0,
                        decoration: new BoxDecoration(
                          color: Colors.transparent,
                          border:
                              new Border.all(color: Colors.white, width: 2.0),
                          borderRadius: new BorderRadius.circular(0.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(6.0),
                          child: new Center(
                            child: new Text(
                              'REGISTER',
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
          )),
    );
  }
}
