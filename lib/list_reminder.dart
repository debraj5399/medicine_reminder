import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'Database/note.dart';
import 'Database/database_helper.dart';
import 'add_reminder.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:translator/translator.dart';
import 'landing.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'login.dart';
import 'list_appointments.dart';
import 'about us.dart';

final translator = new GoogleTranslator();
//global for transalation
String appbarnmae = "Reminders !!";
String remdelete = 'Reminder Deleted Successfully';
String noreminders = "No Reminder's Yet !!";
String areyousure = 'Are you sure?';
String doyouwanttoexit = 'Do you want to exit the app !';
String yes = "Yes";
String no = "No";

class NoteList extends StatefulWidget {
  String langid;
  final String name;
  NoteList({this.langid, this.name});
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  //transalating
  void trans(String lanid) {
    translator.translate(appbarnmae, to: lanid).then((output) {
      setState(() {
        appbarnmae = output;
      });
    });

    translator.translate(remdelete, to: lanid).then((output) {
      setState(() {
        remdelete = output;
      });
    });

    translator.translate(noreminders, to: lanid).then((output) {
      setState(() {
        noreminders = output;
      });
    });

    translator.translate(areyousure, to: lanid).then((output) {
      setState(() {
        areyousure = output;
      });
    });

    translator.translate(doyouwanttoexit, to: lanid).then((output) {
      setState(() {
        doyouwanttoexit = output;
      });
    });

    translator.translate(yes, to: lanid).then((output) {
      setState(() {
        yes = output;
      });
    });

    translator.translate(no, to: lanid).then((output) {
      setState(() {
        no = output;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.trans(
      widget.langid,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            appbarnmae,
            style: TextStyle(
              fontFamily: "SourceSansPro",
            ),
          ),
          backgroundColor: Colors.green,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.translate),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Lang(
                          name: widget.name,
                        )));
              },
            ),
            IconButton(
              icon: Icon(MdiIcons.logout),
              onPressed: () {
                clear();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  widget.name.toString(),
                  style: TextStyle(fontSize: 20.0),
                ),
                accountEmail: Text(""),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.person_pin,
                  color: Colors.green,
                  size: 25.0,
                ),
                title: Text("Appointments",
                    style:
                        TextStyle(fontSize: 18.0, fontFamily: "SourceSansPro")),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PointList(
                            langid: widget.langid,
                            name: widget.name,
                          )));
                },
              ),
              Divider(
                color: Colors.green,
                height: 2.0,
              ),
              ListTile(
                leading: Icon(
                  Icons.developer_board,
                  color: Colors.green,
                  size: 25.0,
                ),
                title: Text("About Us !!",
                    style:
                        TextStyle(fontSize: 18.0, fontFamily: "SourceSansPro")),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => About(
                            name: widget.name,
                            loginid: widget.langid,
                          )));
                },
              )
            ],
          ),
        ),
        body: getNoteListView(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            debugPrint('FAB clicked');
            navigateToDetail(Note('', '', '', '', '', 5), 'My medicines !!');
          },
          tooltip: 'Add Note',
          child: Icon(
            Icons.add,
            size: 30.0,
          ),
        ),
      ),
    );
  }

  Container getNoteListView() {
    print(this.noteList.toString());

    TextStyle titleStyle = TextStyle(
      fontFamily: "SourceSansPro",
    );

    if (this.noteList.toString() == "[]") {
      return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(50.0),
          child: Column(
            children: <Widget>[
              Divider(
                color: Colors.transparent,
                height: 50.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Center(
                  child: Image(
                    image: AssetImage("img/nothing.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Divider(
                color: Colors.transparent,
                height: 20.0,
              ),
              Text(noreminders,
                  style: TextStyle(fontSize: 30.0, fontFamily: "SourceSansPro"))
            ],
          ));
    } else {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: count,
          itemBuilder: (BuildContext context, int position) {
            return Dismissible(
              key: Key(noteList.toString()),
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    // getPriorityColor(this.noteList[position].priority),//
                    child: getPriorityIcon(this.noteList[position].priority),
                  ),
                  title: Text(
                    this.noteList[position].title,
                    style: titleStyle,
                  ),
                  subtitle: Text(this.noteList[position].date),
                  onTap: () {
                    debugPrint("ListTile Tapped");
                    navigateToDetailList(
                        this.noteList[position], 'My Medicine !!');
                  },
                ),
              ),
              onDismissed: (direction) {
                _delete(context, noteList[position]);
                deletepid(noteList[position].pid);
              },
              background: Container(
                color: Colors.red,
                padding: EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30.0,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30.0,
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }

  // Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.green;
        break;
      case 3:
        return Colors.green;
        break;
      case 4:
        return Colors.green;
        break;

      default:
        return Colors.green;
    }
  }

  // Returns the priority icon
  Image getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Image(
          image: AssetImage("img/tablets.png"),
          fit: BoxFit.cover,
        );
        break;
      case 2:
        return Image(
          image: AssetImage("img/pills.png"),
          fit: BoxFit.cover,
        );
        break;
      case 3:
        return Image(
          image: AssetImage("img/injection.png"),
          fit: BoxFit.cover,
        );
        break;
      case 4:
        return Image(
          image: AssetImage("img/serum.png"),
          fit: BoxFit.cover,
        );
        break;
      case 5:
        return Image(
          image: AssetImage("img/syrup.png"),
          fit: BoxFit.cover,
        );
        break;

      default:
        return Image(
          image: AssetImage("img/tablets.png"),
          fit: BoxFit.cover,
        );
    }
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, remdelete);
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Note note, String title) async {
    clicked = false;
    days.clear();
    times.clear();
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title, widget.langid, widget.name);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void navigateToDetailList(Note note, String title) async {
    days.clear();
    times.clear();
    clicked = true;
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title, widget.langid, widget.name);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
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

  List pids = List();

  void deletepid(String data) {
    data = data.replaceAll("[", "");
    data = data.replaceAll("]", "");
    pids = (data.split(','));
    print("we have pids" + pids.toString());
    for (int i = 0; i < pids.length; i++) {
      print("pid no this is been deleted" + pids[i].toString());
      FlutterLocalNotificationsPlugin().cancel(int.parse(pids[i].toString()));
    }
  }
}
