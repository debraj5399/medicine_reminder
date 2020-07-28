import 'package:flutter/material.dart';
import 'package:clipboard_manager/clipboard_manager.dart';

class About extends StatefulWidget {
  final String loginid;
  final String name;

  About(
    {
      this.name,
      this.loginid
    }
  ); 
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us !"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        color: Colors.black87,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            Divider(
              color: Colors.transparent,
              height: 15.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "img/green.png",
                  height: 120.0,
                  width: 120.0,
                )
              ],
            ),
            Divider(
              color: Colors.transparent,
              height: 5.0,
            ),

            //Divider(color: Colors.white,height: 0.0,),
            SizedBox(
              height: 10.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "'Meds Reminder !!'",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30.0),
                ),
                //Text("Cuisine",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
              ],
            ),
            SizedBox(
              height: 10.0,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Copyright © Ver 0.0.1",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )
              ],
            ),

            SizedBox(
              height: 10.0,
            ),

            Divider(
              color: Colors.white,
              height: 0.0,
            ),

            SizedBox(
              height: 10.0,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Get in touch with our Devlopers !",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),

            Divider(
              color: Colors.white,
              height: 0.0,
            ),

            SizedBox(
              height: 10.0,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Your Queries at : ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )
              ],
            ),

            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Image.asset(
            //       "img/dev.png",
            //       height: 240.0,
            //       width: 220.0,
            //     )
            //   ],
            // ),

            SizedBox(
              height: 10.0,
            ),

            Divider(
              color: Colors.white,
              height: 0.0,
            ),

            SizedBox(
              height: 10.0,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
              height: 5.0,
            ),
                Text(
                  "Mail us at : flutteroid.dev@gmail.com",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )
              ],
            ),

            SizedBox(
              height: 10.0,
            ),
            Divider(  
              color: Colors.white,
              height: 0.0,
            ),
            Divider(
              height: 10.0,
              color: Colors.transparent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Made with ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                Text(
                  " in Flutter",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
