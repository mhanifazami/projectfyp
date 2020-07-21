import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp4/screens/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _MyAlarmScreenState createState() => _MyAlarmScreenState();
}

class _MyAlarmScreenState extends State<AlarmScreen> {
  bool alarm = false;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  // var initializationSettingsAndroid;
  // var initializationSettingsIOS;
  // var initializationSettings;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/logo_launcher3');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  showNotification() async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'EzCam3.0', 'Emergency in Surada Residence!', platform,
        payload: 'Nitish Kumar Singh is part time Youtuber');
  }

  Future onSelectNotification(String payload) async {
    await Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new MainScreen()));
  }

  Widget _afteralarmIcon() {
    return IconButton(
        icon: Icon(Icons.notifications_active, color: Colors.white),
        iconSize: 300,
        onPressed: () {});
  }

  Widget _beforealarmIcon() {
    return IconButton(
        icon: Icon(Icons.notifications, color: Colors.white),
        iconSize: 300,
        onPressed: () {
          setState(() {
            alarm = true;
            showNotification();
            Fluttertoast.showToast(
                msg: "Succesfully notified!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black38,
                textColor: Colors.white,
                fontSize: 16.0);
          });
        });
  }

  Widget _beforeClick() {
    return Center(
        child: Text("Press this alarm to send emergency only!",
            style: GoogleFonts.montserrat(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white)));
  }

  Widget _afterClick() {
    return Center(
        child: Text("Already notified!",
            style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21254A),
      appBar: AppBar(
        title: Text("Alarm"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(child: alarm ? _afteralarmIcon() : _beforealarmIcon()),
          SizedBox(height: 20),
          Center(child: alarm ? _afterClick() : _beforeClick())
        ],
      )),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('AlertPage'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('go Back ...'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
