import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'Database/note.dart';
import 'Database/database_helper.dart';
import 'package:intl/intl.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:flutter_tags/tag.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'list_reminder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'trial.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void mains() async {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
}

//Gloabal for change in language
String testing = "Let us know\nWhat medicines you take !!";
String medname = "Medicine Name :";
String consultant = "Consulted By :";
String whattypemed = "What type of medicine is it : ";
String sevdays = "On Several Days Such as ";
String setimes = "On Times like ";
String remindme = 'REMIND ME !!';
String status = "Status";
String remindersaved = 'Reminder Saved Successfully';
String time = "Time";
String disease = "Disease ?";

bool clicked = false;
List<String> days = List();
List<String> times = List();

class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  final Note note;
  final String langid;
  final String name;

  NoteDetail(this.note, this.appBarTitle, this.langid, this.name);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  final format = DateFormat("HH:mm");
  int no;

  static var _priorities = ['Tablets', 'Pills', 'Injection', 'Serum', 'Syrup'];
  List<String> drugs = List();

//Database
  DatabaseHelper helper = DatabaseHelper();
  String appBarTitle;
  Note note;

//Textcontroller
  TextEditingController titleController = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

//constructor
  NoteDetailState(this.note, this.appBarTitle);

  //transalating
  void trans(String lanid) {
    translator.translate(testing, to: lanid).then((output) {
      setState(() {
        testing = output;
      });
    });

    translator.translate(medname, to: lanid).then((output) {
      setState(() {
        medname = output;
      });
    });

    translator.translate(consultant, to: lanid).then((output) {
      setState(() {
        consultant = output;
      });
    });

    translator.translate(whattypemed, to: lanid).then((output) {
      setState(() {
        whattypemed = output;
      });
    });

    translator.translate(sevdays, to: lanid).then((output) {
      setState(() {
        sevdays = output;
      });
    });

    translator.translate(setimes, to: lanid).then((output) {
      setState(() {
        setimes = output;
      });
    });

    translator.translate(remindme, to: lanid).then((output) {
      setState(() {
        remindme = output;
      });
    });

    translator.translate(appBarTitle, to: lanid).then((output) {
      setState(() {
        appBarTitle = output;
      });
    });

    translator.translate(status, to: lanid).then((output) {
      setState(() {
        status = output;
      });
    });

    translator.translate(remindersaved, to: lanid).then((output) {
      setState(() {
        remindersaved = output;
      });
    });

    translator.translate(disease, to: lanid).then((output) {
      setState(() {
        disease = output;
      });
    });
  }

  //notisfications

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }

  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  initializeNotifications() async {
    var initializeAndroid = AndroidInitializationSettings('ic_launcher');
    var initializeIOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(initializeAndroid, initializeIOS);
    await localNotificationsPlugin.initialize(initSettings);
  }

  void  _showWeeklyAtDayAndTime(Day alarmDay, int alarmhour,
      int alarmMin, int alarmId, String alarmTitle) async {
    var time = Time(alarmhour, alarmMin, 0);
    // var times = Time(21, 19, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'show weekly channel id',
        'show weekly channel name',
        'show weekly description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        alarmId,
        "Time to take $alarmTitle",
        'Weekly notification on Monday for  at ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
        alarmDay,
        time,
        platformChannelSpecifics);
    print("Alerm set");
    // await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
    //     4,
    //     'Zeintac',
    //     'Weekly notification shown on Monday at approximately ${_toTwoDigitString(times.hour)}:${_toTwoDigitString(times.minute)}:${_toTwoDigitString(times.second)}',
    //     Day.Monday,
    //     times,
    //     platformChannelSpecifics);
    //
  }

  Future singleNotification(
      DateTime datetime, String message, String subtext, int hashcode,
      {String sound}) async {
    var androidChannel = AndroidNotificationDetails(
      'channel-id',
      'channel-name',
      'channel-description',
      importance: Importance.Max,
      priority: Priority.Max,
    );

    var iosChannel = IOSNotificationDetails();
    var platformChannel = NotificationDetails(androidChannel, iosChannel);
    localNotificationsPlugin.schedule(
        hashcode, message, subtext, datetime, platformChannel,
        payload: hashcode.toString());
  }

  @override
  void initState() {
    mains();
    initializeNotifications();

    super.initState();
    trans(widget.langid);
    if (clicked == true) {
      descTodays();
      descToTimes();
    } else {
      clicked = false;
      days.clear();
      times.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = note.title;
    descriptionController.text = note.description;

    return WillPopScope(
        onWillPop: () {
          moveToLastScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              appBarTitle,
              style: TextStyle(
                fontFamily: "SourceSansPro",
              ),
            ),
            backgroundColor: Colors.green,
            centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  moveToLastScreen();
                }),
          ),
          body: Container(
            padding: EdgeInsets.only(
                top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
            child: ListView(
              children: <Widget>[
//First
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    testing,
                    style:
                        TextStyle(fontFamily: "SourceSansPro", fontSize: 30.0),
                  ),
                ),

// Second
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: titleController,
                    onChanged: (value) {
                      debugPrint('Something changed in Title Text Field');
                      updateTitle();
                    },
                    style: new TextStyle(
                      fontFamily: "SourceSansPro",
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                    autocorrect: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      // suffixIcon: Icon(
                      //   Icons.supervised_user_circle,
                      //   color: Colors.black,
                      // ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      labelText: medname,
                      labelStyle: new TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: "SourceSansPro"),
                    ),
                  ),
                ),

// Third

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      whattypemed + "  ",
                      style: new TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: "SourceSansPro"),
                    ),
                    DropdownButton(
                      items: _priorities.map((dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(
                            dropDownStringItem,
                            style: new TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontFamily: "SourceSansPro"),
                          ),
                        );
                      }).toList(),
                      onChanged: (String valueSelectedByUser) {
                        setState(() {
                          debugPrint('User selected $valueSelectedByUser');
                          updatePriorityAsInt(valueSelectedByUser); //
                        });
                      },
                      value: getPriorityAsString(note.priority),
                    ),
                  ],
                ),

// what type od disease isi it...
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      disease + "  ",
                      style: new TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: "SourceSansPro"),
                    ),
                    DropDown(
                      givenID: 1,
                    ),
                  ],
                ),

//fouth
                Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: TextField(
                      controller: descriptionController,
                      onChanged: (value) {
                        debugPrint('Something changed in Title Text Field');
                        updateDescription();
                      },
                      style: new TextStyle(
                        fontFamily: "SourceSansPro",
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      autocorrect: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        // suffixIcon: Icon(
                        //   Icons.supervised_user_circle,
                        //   color: Colors.black,
                        // ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        labelText: consultant,
                        labelStyle: new TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontFamily: "SourceSansPro"),
                      ),
                    )),

// Fifth
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      sevdays,
                      style: TextStyle(
                        fontFamily: "SourceSansPro",
                        fontSize: 18.0,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        _dayslist();
                      },
                    )
                  ],
                ),

//Sixth
                Tags(
                  itemCount: days.length,
                  itemBuilder: (int index) {
                    return Tooltip(
                        message: days[index],
                        child: ItemTags(
                          activeColor: Colors.green,
                          index: index,
                          title: days[index],
                          removeButton:
                              ItemTagsRemoveButton(icon: MdiIcons.cancel),
                          onRemoved: () {
                            setState(() {
                              days.removeAt(index);
                            });
                          },
                        ));
                  },
                ),

                Divider(
                  color: Colors.transparent,
                  height: 20.0,
                ),

//Seventh

                DateTimeField(
                  controller: timecontroller,
                  onChanged: (value) {
                    debugPrint('Something changed in Title Text Field');
                    if (timecontroller.text == "") {
                    } else {
                      times.add(timecontroller.text);
                    }
                    setState(() {
                      timecontroller.text = "";
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    // suffixIcon: Icon(
                    //   Icons.supervised_user_circle,
                    //   color: Colors.black,
                    // ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    labelText: time,
                    labelStyle: new TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontFamily: "SourceSansPro"),
                  ),
                  format: format,
                  onShowPicker: (context, currentValue) async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.convert(time);
                  },
                ),

                Divider(
                  color: Colors.transparent,
                  height: 20.0,
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     Text(
                //       setimes,
                //       style: TextStyle(
                //         fontFamily: "SourceSansPro",
                //         fontSize: 18.0,
                //       ),
                //     ),
                //     IconButton(
                //       icon: Icon(
                //         Icons.arrow_drop_down_circle,
                //         color: Colors.green,
                //       ),
                //       onPressed: () {
                //         _timelist();
                //       },
                //     )
                //   ],
                // ),

                Tags(
                  itemCount: times.length,
                  itemBuilder: (int index) {
                    return Tooltip(
                        message: times[index],
                        child: ItemTags(
                          activeColor: Colors.green,
                          index: index,
                          title: times[index],
                          removeButton:
                              ItemTagsRemoveButton(icon: MdiIcons.cancel),
                          onRemoved: () {
                            setState(() {
                              times.removeAt(index);
                            });
                          },
                        ));
                  },
                ),

                Divider(
                  color: Colors.transparent,
                  height: 30.0,
                ),
                // RaisedButton(
                //   child: Text("Testing"),
                //   onPressed: () {
                //     FlutterLocalNotificationsPlugin().cancelAll();
                //   },
                // ),

//Eigth Save
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new InkWell(
                      onTap: () async {
                        String name = titleController.text;
                        String consult = descriptionController.text;

                        if (days.toString() == "[]" ||
                            times.toString() == "[]" ||
                            name.length < 3 ||
                            consult.length < 3) {
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
                        } else {
                          note.days = days.toString();
                          note.times = times.toString();

                          clicked = false;
                          setDayAlarm(titleController.text);
                          print("the pidno ares" + pidNo.toString());
                          note.pid = pidNo.toString();
                          print("we have in note.pid is " + note.pid);
                          _save();
                          moveToLastScreen();
                        }
                      },
                      child: new Container(
                          width: 180.0,
                          height: 40.0,
                          decoration: new BoxDecoration(
                            color: Colors.transparent,
                            border:
                                new Border.all(color: Colors.green, width: 2.0),
                            borderRadius: new BorderRadius.circular(0.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: new Center(
                              child: new Text(
                                remindme,
                                style: new TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "SourceSansPro",
                                    color: Colors.green),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  void _dayslist() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 400.0,
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  CheckboxGroup(
                      activeColor: Colors.green,
                      labels: <String>[
                        "Sunday",
                        "Monday",
                        "Tuesday",
                        "Wednesday",
                        "Thursday",
                        "Friday",
                        "Saturday",
                      ],
                      onChange: (bool isChecked, String label, int index) => print(
                          "isChecked: $isChecked   label: $label  index: $index"),
                      onSelected: (List<String> checked) {
                        setState(() {
                          days = checked;
                        });
                        print("checked: ${checked.toString()}");
                      }),
                ],
              ),
            ),
          );
        });
  }

  void _timelist() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 400.0,
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  CheckboxGroup(
                      activeColor: Colors.green,
                      labels: <String>[
                        "Before BreakFast",
                        "After BreakFast",
                        "Before Lunch",
                        "After Lunch",
                        "Before Bed",
                        "After Bed"
                      ],
                      onChange: (bool isChecTime, String label, int index) => print(
                          "isChecked: $isChecTime   label: $label  index: $index"),
                      onSelected: (List<String> chectime) {
                        setState(() {
                          times = chectime;
                        });
                        print("checked: ${chectime.toString()}");
                      }),
                ],
              ),
            ),
          );
        });
  }

  void moveToLastScreen() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NoteList(
              langid: widget.langid,
              name: widget.name,
            )));
  }

  // Convert the String priority in the form of integer before saving it to Database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'Tablets':
        note.priority = 1;
        break;
      case 'Pills':
        note.priority = 2;
        break;
      case 'Injection':
        note.priority = 3;
        break;
      case 'Serum':
        note.priority = 4;
        break;
      case 'Syrup':
        note.priority = 5;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0]; // 'High'
        break;
      case 2:
        priority = _priorities[1]; // 'Low'
        break;
      case 3:
        priority = _priorities[2]; // 'Low'
        break;
      case 4:
        priority = _priorities[3]; // 'Low'
        break;
      case 5:
        priority = _priorities[4]; // 'Low'
        break;
    }
    return priority;
  }

  // Update the title of Note object
  void updateTitle() {
    note.title = titleController.text;
  }

  // Update the description of Note object
  void updateDescription() {
    note.description = descriptionController.text;
  }

  // Save data to database
  void _save() async {
    print("saving it");
    moveToLastScreen();

    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      // Case 1: Update operation
      result = await helper.updateNote(note);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertNote(note);
    }

    if (result != 0) {
      // Success
      _showAlertDialog(status, remindersaved);
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }

  void _delete() async {
    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (note.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteNote(note.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        title,
        style: new TextStyle(
          fontFamily: "SourceSansPro",
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        message,
        style: new TextStyle(
          fontFamily: "SourceSansPro",
        ),
      ),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  //conversions
  void descTodays() {
    note.days = note.days.replaceAll("[", "");
    note.days = note.days.replaceAll("]", "");
    days = (note.days.split(','));
  }

  void descToTimes() {
    note.times = note.times.replaceAll("[", "");
    note.times = note.times.replaceAll("]", "");
    times = (note.times.split(','));
  }

  randomGenerate() {
    var rng = new Random();
    no = rng.nextInt(100000);
    print("Random No Is: " + no.toString());
  }

//on appropriate for days
  void setDayAlarm(String sdaTitle) {
    for (int i = 0; i < days.length; i++) {
      if (days[i].toString() == "Monday") {
        remindDay = Day.Monday;

        setTimeAlarm(remindDay, sdaTitle);
      } else if (days[i].toString() == "Tuesday") {
        remindDay = Day.Tuesday;

        setTimeAlarm(remindDay, sdaTitle);
      } else if (days[i].toString() == "Wednesday") {
        remindDay = Day.Wednesday;

        setTimeAlarm(remindDay, sdaTitle);
      } else if (days[i].toString() == "Thursday") {
        remindDay = Day.Thursday;

        setTimeAlarm(remindDay, sdaTitle);
      } else if (days[i].toString() == "Friday") {
        remindDay = Day.Friday;

        setTimeAlarm(remindDay, sdaTitle);
      } else if (days[i].toString() == "Saturday") {
        remindDay = Day.Saturday;

        setTimeAlarm(remindDay, sdaTitle);
      } else if (days[i].toString() == "Sunday") {
        remindDay = Day.Sunday;

        setTimeAlarm(remindDay, sdaTitle);
      } else {
        print("continuing");
        continue;
      }
    }
  }

  //om app for times
  void setTimeAlarm(Day staDay, String staTitle) async {
    print(times);
    for (int i = 0; i < times.length; i++) {
      print(staDay.toString());
      randomGenerate();
      pidNo.add(no);
      print("Present " + pidNo.toString());
      String aA = times[i].toString();
      aA = aA.replaceAll(":", "");
      double noo = double.parse(aA);
      noo = noo / 100;

      int n = int.parse(aA);
      int min;
      min = n % 100;
      int hr = noo.floor();

      print(hr);
      print(min);
      print("-----------------------");
       _showWeeklyAtDayAndTime(staDay, hr, min, no, staTitle);
    }
  }

  //all for login
  Day remindDay;
  List pidNo = List();
}
