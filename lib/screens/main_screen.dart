import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import 'camera_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'resident_list_screen.dart';
import 'vehicle_screen.dart';
import 'login_screen.dart';
import 'alarms_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({this.username});
  final String username;
  @override
  _MyMainScreenState createState() => _MyMainScreenState();
}

class _MyMainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: Scaffold(
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
          title: Text("Home"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 70,
                  bottom: 10,
                ),
                child: Center(
                  child: Text(
                    'EzCam v3.0',
                    style: GoogleFonts.roboto(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 50,
                    ),
                    height: 180,
                    width: double.maxFinite,
                    child: Card(
                      child: RaisedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CameraScreen()),
                          );
                        },
                        icon: Icon(Icons.camera),
                        label: Text('Camera'),
                        textColor: Colors.white,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    height: 180,
                    width: double.maxFinite,
                    child: Card(
                      child: RaisedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VehicleRecordScreen()),
                          );
                        },
                        icon: Icon(Icons.data_usage),
                        label: Text('Registered Vehicle'),
                        textColor: Colors.white,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    height: 180,
                    width: double.maxFinite,
                    child: Card(
                      child: RaisedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResidentScreen()),
                          );
                        },
                        icon: Icon(Icons.home),
                        label: Text('Residents'),
                        textColor: Colors.white,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    height: 180,
                    width: double.maxFinite,
                    child: Card(
                      child: RaisedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AlarmScreen()),
                          );
                        },
                        icon: Icon(Icons.alarm),
                        label: Text('Alarms'),
                        textColor: Colors.white,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.purple),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.purple.shade800,
                    size: 96,
                  ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }),
              // Long drawer contents are often segmented.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Details'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
    );
  }
}
