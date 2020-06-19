import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
// import 'vehicle_details_screen.dart';
import 'details/resident_details_screen.dart';
import 'login_screen.dart';
import 'main_screen.dart';

import '../db/resident_db.dart';
import '../db/residents.dart';

String residentid,
    name,
    roadno,
    houseno,
    contactno,
    vid,
    brand,
    type,
    regisdate,
    pic;

// List filter = List();

class ResidentScreen extends StatefulWidget {
  @override
  ResidentScreenState createState() => ResidentScreenState();
}

class ResidentScreenState extends State<ResidentScreen> {
  TextEditingController search = new TextEditingController();
  // List<dynamic> filteredResidents = List();
  List<dynamic> residents = List();

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: MaterialApp(
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
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            title: Text('List of Residents'),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: Theme(
                data: Theme.of(context).copyWith(accentColor: Colors.white),
                child: Container(
                  height: 70.0,
                  width: 415,
                  child: TextField(
                    controller: search,
                    style: GoogleFonts.montserrat(
                        fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      filled: true,
                      fillColor: Color(0xff21254A),
                      hintText: "Search by name...",
                      hintStyle: TextStyle(color: Colors.white54),
                      suffixIcon: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            search.clear();
                            // filteredResidents = residents;
                          }),
                    ),
                    onChanged: (value) {},
                  ),
                ),
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
          body: Center(
            child: FutureBuilder<List>(
              future: Resident.viewData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? new ListView.builder(
                        // residents = snapshot.data,
                        // residents = list;
                        itemCount: snapshot.data.length,
                        // snapshot.data == null ? 0 :
                        // snapshot.data.length,
                        itemBuilder: (context, i) {
                          // final list = snapshot.data;
                          residents = snapshot.data;
                          // filtername = residents[i]['Name'];

                          return new Container(
                            padding: const EdgeInsets.all(0.1),
                            child: new GestureDetector(
                              onTap: () {
                                residentid = residents[i]['ResidentId'];
                                vid = residents[i]['VehicleId'];
                                brand = residents[i]['VehicleBrand'];
                                type = residents[i]['VehicleType'];
                                regisdate = residents[i]['RegistrationDate'];
                                pic = residents[i]['VehiclePicture'];
                                name = residents[i]['Name'];
                                roadno = residents[i]['RoadNo'];
                                houseno = residents[i]['HouseNo'];
                                contactno = residents[i]['ContactNo'];


                                Navigator.of(context)
                                    .pushNamed('/ResidentDetailScreen');
                                // Navigator.pushReplacementNamed(
                                //     context, '/ResidentDetailScreen');
                                Navigator.pop(context);
                              },
                              child: new Card(
                                color: Color(455561),
                                child: new ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: new CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor: Colors.purple,
                                  ),
                                  title: new Text(residents[i]['Name'],
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17))),
                                  subtitle: new Text(
                                    "House Number : ${residents[i]['HouseNo']}",
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
                      )
                    : new Center(
                        child: new CircularProgressIndicator(),
                      );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {},
          ),
        ),
        routes: <String, WidgetBuilder>{
        '/ResidentDetailScreen': (BuildContext context) => new ResidentDetails(
            residentid: residentid,
            vid: vid,
            brand: brand,
            type: type,
            regisdate: regisdate,
            name: name,
            roadno: roadno,
            houseno: houseno,
            contactno: contactno),
      },
      ),
      
    );
  }
}
