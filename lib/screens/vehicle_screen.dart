import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_vehicles.dart';
import 'login_screen.dart';
import 'details/vehicle_details_screen.dart';
import '../db/vehicle_db.dart';
import 'main_screen.dart';

String residentid,
    vid,
    brand,
    type,
    regisdate,
    pic,
    name,
    roadno,
    houseno,
    contactno;

class VehicleRecordScreen extends StatefulWidget {
  @override
  VehicleRecordScreenState createState() => VehicleRecordScreenState();
}

class VehicleRecordScreenState extends State<VehicleRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: MaterialApp(
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
                      leading: Icon(Icons.power_settings_new),
                      title: Text('Logout'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
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
                                .where((list) =>
                                    list['VehicleType'] == 'Motorcycle')
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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddVehicle()));
              },
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
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemList extends StatefulWidget {
  List<dynamic> list;
  // ItemList({this.list});
  ItemList({this.list});

  _MyItemState createState() => _MyItemState();
}

class _MyItemState extends State<ItemList> {
  List<dynamic> vehicleList = List<dynamic>();
  TextEditingController search = new TextEditingController();

  @override
  void initState() {
    setState(() {
      vehicleList = widget.list;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: vehicleList == null ? 0 : vehicleList.length + 1,
      itemBuilder: (context, i) {
        return i == 0
            ? _searchBar()
            : _listVehicle(i - 1, context, vehicleList);
      },
    );
  }

  _searchBar() {
    return Container(
        width: double.infinity,
        color: Colors.purple,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.white),
              child: Container(
                height: 70.0,
                width: 415,
                child: TextField(
                  controller: search,
                  style:
                      GoogleFonts.montserrat(fontSize: 16, color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    filled: true,
                    fillColor: Color(0xff21254A),
                    hintText: "Search by car brand...",
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                  onChanged: (text) {
                    setState(() {
                      text = text.toLowerCase();
                      setState(() {
                        vehicleList = widget.list.where((element) {
                          var vehicleBrand =
                              element['VehicleBrand'].toLowerCase();
                          return vehicleBrand.contains(text);
                        }).toList();
                      });
                    });
                  },
                ),
              ),
            )));
  }

  _listVehicle(i, context, list) {
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
                    textStyle: TextStyle(color: Colors.white, fontSize: 17))),
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
  }
}
