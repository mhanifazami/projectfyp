import 'package:flutter/material.dart';
import 'package:fyp4/screens/add_residents.dart';
import 'package:google_fonts/google_fonts.dart';
import 'details/resident_details_screen.dart';
import 'login_screen.dart';
import 'main_screen.dart';

import '../db/resident_db.dart';

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
  String filter;

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
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
                    onChanged: (value) {
                      setState(() {
                        filter = value;
                      });
                    },
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              new GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                },
                child: Center(
                  child: Text("Back"),
                ),
              )
            ],
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
                                // vid = residents[i]['VehicleId'];
                                // brand = residents[i]['VehicleBrand'];
                                // type = residents[i]['VehicleType'];
                                // regisdate = residents[i]['RegistrationDate'];
                                // pic = residents[i]['VehiclePicture'];
                                name = residents[i]['Name'];
                                roadno = residents[i]['RoadNo'];
                                houseno = residents[i]['HouseNo'];
                                contactno = residents[i]['ContactNo'];

                                Navigator.of(context)
                                    .pushNamed('/ResidentDetailScreen');
                                // Navigator.pushReplacementNamed(
                                //     context, '/ResidentDetailScreen');
                                // Navigator.pop(context);
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
                                  title: new Text(
                                      residents[i]['Name'] ??
                                          residents[i]['Name']
                                              .contains(filter.toLowerCase()),
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17))),
                                  subtitle: new Text(
                                    "House Number : ${residents[i]['HouseNo']}" ??
                                        "House Number : ${residents[i]['HouseNo'].contains(filter.toLowerCase())}",
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
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddResident()));
            },
          ),
        ),
        routes: <String, WidgetBuilder>{
          '/ResidentDetailScreen': (BuildContext context) =>
              new ResidentDetails(
                  residentid: residentid,
                  name: name,
                  roadno: roadno,
                  houseno: houseno,
                  contactno: contactno),
        },
      ),
    );
  }
}
