import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'main_screen.dart';

class AlarmScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyAlarmScreen(title: 'Alarm'),
    );
  }
}

class MyAlarmScreen extends StatefulWidget {
  MyAlarmScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyAlarmScreenState createState() => _MyAlarmScreenState();
}

class _MyAlarmScreenState extends State<MyAlarmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21254A),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(widget.title),
      ),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new SizedBox(
              width: double.infinity,
              height: 50.0,
              child: RaisedButton.icon(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => TakePictureScreen(
                  //             camera: null,
                  //           )),
                  // );
                },
                icon: Icon(Icons.camera),
                label: Text('Camera'),
                textColor: Colors.white,
                color: Colors.blue,
              ),
            ),
            new SizedBox(
              width: double.infinity,
              height: 50.0,
              child: RaisedButton.icon(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => HomeRecordScreen()),
                  // );
                },
                icon: Icon(Icons.data_usage),
                label: Text('Registered Vehicle'),
                textColor: Colors.white,
                color: Colors.red,
              ),
            ),

          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: CircleAvatar(
                // backgroundImage: new FileImage(),
                radius: 100.0,
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
            ),
            ListTile(
              leading: Icon(Icons.perm_identity),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
                // Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
                // Navigator.pop(context);
              },
            ),
            ListTile(
                leading: Icon(Icons.power_settings_new),
                title: Text('Logout'),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => LoginScreen()),
                  // );
                })
          ],
        ),
      ),
    );
  }
}
