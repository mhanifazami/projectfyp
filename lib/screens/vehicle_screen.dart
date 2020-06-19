import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'login_screen.dart';
import 'details/vehicle_details_screen.dart';
import '../db/vehicle_db.dart';
import 'main_screen.dart';

String residentid, vid, brand, type, regisdate, pic, name, roadno, houseno, contactno;

class VehicleRecordScreen extends StatefulWidget {
  @override
  VehicleRecordScreenState createState() => VehicleRecordScreenState();
}

class VehicleRecordScreenState extends State<VehicleRecordScreen> {
  TextEditingController search = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Color(0xff21254A),
          appBar: AppBar(
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
            bottom: TabBar(
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_bus)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('List of Registered Vehicle'),
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
          body: TabBarView(
            children: [
              new FutureBuilder<List>(
                future: Vehicle.viewData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? new ItemList(
                          list: snapshot.data
                              .where((list) => list['VehicleType'] == 'Car')
                              .toList(),
                        )
                      : new Center(
                          child: new CircularProgressIndicator(),
                        );
                },
              ),
              new FutureBuilder<List>(
                future: Vehicle.viewData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? new ItemList(
                          list: snapshot.data
                              .where((list) => list['VehicleType'] == 'Lorry')
                              .toList(),
                        )
                      : new Center(
                          child: new CircularProgressIndicator(),
                        );
                },
              ),
              new FutureBuilder<List>(
                future: Vehicle.viewData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? new ItemList(
                          list: snapshot.data
                              .where(
                                  (list) => list['VehicleType'] == 'Motorcycle')
                              .toList(),
                        )
                      : new Center(
                          child: new CircularProgressIndicator(),
                        );
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {},
          ),
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/VehicleDetailScreen': (BuildContext context) => new VehicleDetails(
            residentid: residentid,
            vid: vid,
            brand: brand,
            type: type,
            regisdate: regisdate,
            pic: pic,
            name: name,
            roadno: roadno,
            houseno: houseno,
            contactno: contactno),
      },
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          // padding: const EdgeInsets.all(1),
          child: new GestureDetector(
            onTap: () {
              residentid = list[i]['ResidentId'];
              vid = list[i]['VehicleId'];
              brand = list[i]['VehicleBrand'];
              type = list[i]['VehicleType'];
              regisdate = list[i]['RegistrationDate'];
              pic = list[i]['VehiclePicture'];
              name = list[i]['Name'];
              roadno = list[i]['RoadNo'];
              houseno = list[i]['HouseNo'];
              contactno = list[i]['ContactNo'];

              print(name);
              print(roadno);
              print(houseno);

              Navigator.of(context).pushNamed('/VehicleDetailScreen');
              // Navigator.pushReplacementNamed(context, '/VehicleDetailScreen');
              // Navigator.pop(context);
            },
            child: new Card(
              color: Color(455561),
              child: new ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: new CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      "http://lrgs.ftsm.ukm.my/users/a159159/${list[i]['VehiclePicture']}"),
                  backgroundColor: Colors.transparent,
                ),
                title: new Text(list[i]['VehicleBrand'],
                    style: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 17))),
                subtitle: new Text(
                  "Plate : ${list[i]['VehicleId']}",
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w100,
                  )),
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  size: 30,
                  color: Colors.white,
                ),
                selected: true,
              ),
            ),
          ),
        );
      },
    );
  }
}
