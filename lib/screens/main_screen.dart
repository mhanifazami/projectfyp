import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'resident_list_screen.dart';
import 'vehicle_screen.dart';
import 'login_screen.dart';
import 'alarms_screen.dart';
import 'live_stream.dart';

var carin,
    carout,
    motorin,
    motorout,
    busin,
    busout,
    totalcar,
    totalbus,
    totalmotor;

class MainScreen extends StatefulWidget {
  @override
  _MyMainScreenState createState() => _MyMainScreenState();
}

class _MyMainScreenState extends State<MainScreen> {
  List<dynamic> vehiclenum = List<dynamic>();
  bool anomaly = false;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // var initializationSettingsAndroid;
  // var initializationSettingsIOS;
  // var initializationSettings;

  @override
  void initState() {
    _getData();
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/logo_launcher3');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    // setState(() {
    //   checkAnomaly();
    // });
    // checkAnomaly();
  }

  checkAnomaly() {
    if (totalcar > 1) {
      showNotificationCar();
    }
    if (totalbus >= 4) {
      showNotificationBus();
    }
    if (totalmotor > 4) {
      showNotificationMotor();
    }
  }

  showNotificationCar() async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'EzCam3.0', 'The total record car exceeds 1 today!', platform,
        payload: 'Nitish Kumar Singh is part time Youtuber');
  }

  showNotificationBus() async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'EzCam3.0', 'Emergency in Surada Residence!', platform,
        payload: 'Nitish Kumar Singh is part time Youtuber');
  }

  showNotificationMotor() async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'EzCam3.0', 'The total record motor exceeds 4 today!', platform,
        payload: 'Nitish Kumar Singh is part time Youtuber');
  }

  Future onSelectNotification(String payload) async {
    await Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new MainScreen()));
  }

  Future<List> _getData() async {
    final response = await http
        .get('http://lrgs.ftsm.ukm.my/users/a159159/report_daily.php');

    return json.decode(response.body);
  }

  _getRecordVehicle() {
    return FutureBuilder<List>(
      future: _getData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? new ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  vehiclenum = snapshot.data;
                  if (vehiclenum[i]['vehicleType'] == "CAR" &&
                      vehiclenum[i]['vehicleFlow'] == "IN") {
                    carin = vehiclenum[i]['Total'];
                  }
                  if (vehiclenum[i]['vehicleType'] == "CAR" &&
                      vehiclenum[i]['vehicleFlow'] == "OUT") {
                    carout = vehiclenum[i]['Total'];
                  }
                  if (vehiclenum[i]['vehicleType'] == "MOTOR" &&
                      vehiclenum[i]['vehicleFlow'] == "IN") {
                    motorin = vehiclenum[i]['Total'];
                  }
                  if (vehiclenum[i]['vehicleType'] == "MOTOR" &&
                      vehiclenum[i]['vehicleFlow'] == "OUT") {
                    motorout = vehiclenum[i]['Total'];
                  }
                  if (vehiclenum[i]['vehicleType'] == "BUS" &&
                      vehiclenum[i]['vehicleFlow'] == "IN") {
                    busin = vehiclenum[i]['Total'];
                  }
                  if (vehiclenum[i]['vehicleType'] == "BUS" &&
                      vehiclenum[i]['vehicleFlow'] == "OUT") {
                    busout = vehiclenum[i]['Total'];
                  }
                  return Divider(
                    height: 0,
                  );
                },
              )
            : new Center(
                child: new CircularProgressIndicator(),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.purple),
        home: Scaffold(
          backgroundColor: Color(0xff21254A),
          appBar: AppBar(
            elevation: 0,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            title: Text("Home"),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.refresh, color: Colors.white),
                  onPressed: () {
                    setState(() {});
                  })
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Wrap(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(36),
                                  bottomRight: Radius.circular(36))),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        Text("Today's Record",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white)),
                                        Spacer(),
                                        // Text(
                                        //   "View more >>",
                                        //   style: TextStyle(
                                        //       fontSize: 15,
                                        //       color: Colors.white),
                                        // )
                                      ],
                                    ),
                                  )),
                              _getRecordVehicle(),
                              Center(
                                child: Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 30),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            _gridItem(Icons.directions_car,
                                                "In :  ", carin ?? "0"),
                                            _gridItem(Icons.motorcycle,
                                                "In :  ", motorin ?? "0"),
                                            _gridItem(Icons.local_shipping,
                                                "In :  ", busin ?? "0"),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            _gridItem(Icons.directions_car,
                                                "Out :  ", carout ?? "0"),
                                            _gridItem(Icons.motorcycle,
                                                "Out :  ", motorout ?? "0"),
                                            _gridItem(Icons.local_shipping,
                                                "Out :  ", busout ?? "0"),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                      child: Text("Features",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _listItem(Icons.camera, LiveScreen(), "Camera",
                              Colors.blue),
                          SizedBox(width: 5),
                          _listItem(Icons.alarm, AlarmScreen(), "Alarms",
                              Colors.indigo),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                      child: Text("List",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _listItem(Icons.people, ResidentScreen(), "Residents",
                              Colors.purple),
                          SizedBox(width: 5),
                          _listItem(Icons.directions_car, VehicleRecordScreen(),
                              "Vehicles", Colors.red),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
      ),
    );
  }

  Widget _gridItem(icon, label, text) {
    return Column(
      children: [
        CircleAvatar(
          child: Icon(
            icon,
            size: 30.0,
            color: Colors.white,
          ),
          radius: 30,
          backgroundColor: Color(0xff21254A),
        ),
        SizedBox(height: 10),
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(color: Colors.white70, fontSize: 15),
            children: <TextSpan>[
              TextSpan(
                  text: text.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _listItem(icon, route, text, color) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
        width: width * 0.43,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: color),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              child: Icon(icon, size: 30, color: Colors.white),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(text,
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
      },
    );
  }
}
