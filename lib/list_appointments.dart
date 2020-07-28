import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'Database/appointment.dart';
import 'Database/db_helper_app.dart';
import 'package:sqflite/sqflite.dart';
import 'package:translator/translator.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'login.dart';
import 'landing.dart';
import 'list_reminder.dart';
import 'add_appointments.dart';


final translator = new GoogleTranslator();
//global for transalation
String appbarnmae = "Appointments !!";
String remdelete = 'Appointment Deleted Successfully';
String noreminders = "No Appointment's Yet !!";
String areyousure = 'Are you sure?';
String doyouwanttoexit = 'Do you want to exit the app !';
String yes = "Yes";
String no = "No";

class PointList extends StatefulWidget {
  final String langid;
  final String name;
  
  PointList({
    this.langid,
    this.name

  });
  @override
  State<StatefulWidget> createState() {
    return PointListState();
  }
}

class PointListState extends State<PointList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Point> noteList;
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
      noteList = List<Point>();
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
              onPressed: ()
              {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Lang(name: widget.name,)));
              },
            ),
            IconButton(
              icon: Icon(MdiIcons.logout),
              onPressed: ()
              {
                clear();
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));
              },
            )
          ],
        ),
       
        body: getNoteListView(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            debugPrint('FAB clicked');
            navigateToDetail(Point('', '', '', '', 5), 'My Appointments !!');
          },
          tooltip: 'Add Point',
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
                  style: TextStyle(fontSize: 25.0, fontFamily: "SourceSansPro"))
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
          image: AssetImage("img/dr.png"),
          fit: BoxFit.cover,
        );
        break;
      case 2:
        return Image(
          image: AssetImage("img/dr.png"),
          fit: BoxFit.cover,
        );
        break;
      case 3:
        return Image(
          image: AssetImage("img/dr.png"),
          fit: BoxFit.cover,
        );
        break;
      case 4:
        return Image(
          image: AssetImage("img/dr.png"),
          fit: BoxFit.cover,
        );
        break;
      case 5:
        return Image(
          image: AssetImage("img/dr.png"),
          fit: BoxFit.cover,
        );
        break;

      default:
        return Image(
          image: AssetImage("img/dr.png"),
          fit: BoxFit.cover,
        );
    }
  }

  void _delete(BuildContext context, Point note) async {
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

  void navigateToDetail(Point note, String title) async {

    days.clear();
    times.clear();
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PointDetail(note, title, widget.langid,widget.name);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void navigateToDetailList(Point note, String title) async {
    days.clear();
    times.clear();

    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PointDetail(note, title, widget.langid,widget.name);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Point>> noteListFuture = databaseHelper.getNoteList();
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
    return Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NoteList(name: widget.name,langid: widget.langid,))) ??
        false;
  }
}
