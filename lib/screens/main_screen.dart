import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import 'camera_screen.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

import 'resident_list_screen.dart';
import 'vehicle_screen.dart';
import 'login_screen.dart';
import 'alarms_screen.dart';

// Future<NumVehicle> getData() async {
//   final response =
//       await http.get('http://lrgs.ftsm.ukm.my/users/a159159/report_daily.php');

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return NumVehicle.fromJson(json.decode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

// class NumVehicle {
//   final String type;
//   final String flow;
//   final int total;

//   NumVehicle({this.type, this.flow, this.total});

//   factory NumVehicle.fromJson(Map<String, dynamic> json) {
//     return NumVehicle(
//       type: json['vehicleType'],
//       flow: json['vehicleFlow'],
//       total: json['Total']
//     );
//   }
// }
String carin, carout, motorin, motorout;

class MainScreen extends StatefulWidget {
  MainScreen({this.username});
  final String username;
  @override
  _MyMainScreenState createState() => _MyMainScreenState();
}

class _MyMainScreenState extends State<MainScreen> {
  List<dynamic> numvehicle = List();

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
              FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? new ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            numvehicle = snapshot.data;
                            if (numvehicle[i]['vehicleType'] == "CAR" &&
                                numvehicle[i]['vehicleFlow'] == "IN") {
                              carin = numvehicle[i]['Total'];
                            }
                            if (numvehicle[i]['vehicleType'] == "CAR" &&
                                numvehicle[i]['vehicleFlow'] == "OUT") {
                              carout = numvehicle[i]['Total'];
                            }
                            if (numvehicle[i]['vehicleType'] == "MOTOR" &&
                                numvehicle[i]['vehicleFlow'] == "IN") {
                              motorin = numvehicle[i]['Total'];
                            }
                            if (numvehicle[i]['vehicleType'] == "MOTOR" &&
                                numvehicle[i]['vehicleFlow'] == "OUT") {
                              motorout = numvehicle[i]['Total'];
                            }
                            return new Divider(
                              height: 10.0,
                              thickness: 10.0,
                            );
                          },
                        )
                      : new Center(child: new CircularProgressIndicator());
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 120),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Car In: " + carin ?? '0', textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(color: Colors.white)),
                      Icon(Icons.directions_car, color: Colors.white),
                      SizedBox(width: 20),
                      Text("Car Out: " + carout ?? '0',
                          style: GoogleFonts.montserrat(color: Colors.white)),
                      Icon(Icons.directions_transit, color: Colors.white),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Motor In: " + motorin ?? '0',
                          style: GoogleFonts.montserrat(color: Colors.white)),
                      Icon(Icons.directions_car, color: Colors.white),
                      SizedBox(width: 20),
                      Text(motorout ?? '0',
                          style: GoogleFonts.montserrat(color: Colors.white)),
                      Icon(Icons.directions_transit, color: Colors.white),
                    ],
                  ),
                ],
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
                      top: 5,
                    ),
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
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
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
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
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
