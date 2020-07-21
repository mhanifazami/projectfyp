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
  List<dynamic> numvehicle = List();
  bool anomaly = false;

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
    setState(() {
      checkAnomaly();
    });
  }

  checkAnomaly() {
    if (totalcar >= 1) {
      showNotificationCar();
    }
    // if (totalbus > 4) {
    //   showNotificationBus();
    // }
    else if (totalmotor >= 4) {
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

  Future<List> getData() async {
    final response = await http
        .get('http://lrgs.ftsm.ukm.my/users/a159159/report_daily.php');
    return json.decode(response.body);
  }

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
                  top: 50,
                  bottom: 30,
                ),
                child: Center(
                    child: Image(image: AssetImage('assets/images/logo.png'))),
              ),
              Center(
                child: Text("Today's Record",
                    style: GoogleFonts.montserrat(
                        fontSize: 20, color: Colors.white)),
              ),
              SizedBox(height: 10),
              FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? new ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            numvehicle = snapshot.data;
                            if (numvehicle[i]['vehicleType'] == "CAR") {
                              if (numvehicle[i]['vehicleFlow'] == "IN") {
                                carin = numvehicle[i]['Total'];
                              } else if (numvehicle[i]['vehicleFlow'] ==
                                  "OUT") {
                                carout = numvehicle[i]['Total'];
                              }
                              totalcar = int.parse(carin) - int.parse(carout);
                            }
                            if (numvehicle[i]['vehicleType'] == "BUS") {
                              if (numvehicle[i]['vehicleFlow'] == "IN") {
                                busin = numvehicle[i]['Total'] ?? 0;
                              } else if (numvehicle[i]['vehicleFlow'] ==
                                  "OUT") {
                                busout = numvehicle[i]['Total'];
                              }
                              // totalbus = int.parse(busin) - int.parse(busout);
                            }
                            if (numvehicle[i]['vehicleType'] == "MOTOR") {
                              if (numvehicle[i]['vehicleFlow'] == "IN") {
                                motorin = numvehicle[i]['Total'];
                              } else if (numvehicle[i]['vehicleFlow'] ==
                                  "OUT") {
                                motorout = numvehicle[i]['Total'];
                              }
                              totalmotor =
                                  int.parse(motorin) - int.parse(motorout);
                            }
                            return new Divider(
                              height: 1.0,
                            );
                          },
                        )
                      : new Center(child: new CircularProgressIndicator());
                },
              ),
              GestureDetector(
                onTap: () {
                  // showNotification();
                  // calculateVehicle();
                  print(totalmotor.toString());
                },
                child: Container(
                  height: 130,
                  width: 180,
                  alignment: FractionalOffset(0.5, 0.2),
                  child: Card(
                      color: Colors.deepPurpleAccent,
                      child: Column(children: <Widget>[
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(children: <Widget>[
                                Icon(Icons.directions_car, color: Colors.white),
                                Text("  In: " + (carin ?? "0"),
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white, fontSize: 15)),
                                Text(" Out: " + (carout ?? "0"),
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white, fontSize: 15))
                              ]),
                            ]),
                        SizedBox(height: 5),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(children: <Widget>[
                                Icon(Icons.directions_bus, color: Colors.white),
                                Text("  In: " + (busin ?? "0"),
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white, fontSize: 15)),
                                Text(" Out: " + (busout ?? "0"),
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white, fontSize: 15))
                              ]),
                            ]),
                        SizedBox(height: 5),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(children: <Widget>[
                                Icon(Icons.directions_bike,
                                    color: Colors.white),
                                Text("  In: " + (motorin ?? "0"),
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white, fontSize: 15)),
                                Text(" Out: " + (motorout ?? "0"),
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white, fontSize: 15))
                              ]),
                            ]),
                      ])),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 50,
                    ),
                    height: 80,
                    width: double.maxFinite,
                    child: Card(
                      child: RaisedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => (LiveScreen())),
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
                    height: 80,
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
                    height: 80,
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
                    height: 80,
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
              // ListTile(
              //   leading: Icon(Icons.perm_identity),
              //   title: Text('Profile'),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => Profile()),
              //     );
              //     // Navigator.pop(context);
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.settings),
              //   title: Text('Settings'),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => Settings()),
              //     );
              //     // Navigator.pop(context);
              //   },
              // ),
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
