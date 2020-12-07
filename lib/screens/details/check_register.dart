import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp4/db/vehicle_db.dart';
import 'package:fyp4/screens/details/vehicle_details_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

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

class CheckScreen extends StatelessWidget {
  final String noplate;

  CheckScreen({Key key, this.noplate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21254A),
      appBar: AppBar(
        title: Text("Check Registration of " + noplate),
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<List>(
            future: Vehicle.viewData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? new ItemList(
                      list: snapshot.data
                          .where((list) =>
                              list['VehicleId'].toLowerCase().contains(noplate))
                          .toList(),
                    )
                  : new Center(
                      child: Text("not matched!"),
                    );
            },
          ),
        ),
      ),
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

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => (VehicleDetails(
                        residentid: residentid,
                        vid: vid,
                        brand: brand,
                        type: type,
                        regisdate: regisdate,
                        pic: pic,
                        name: name,
                        roadno: roadno,
                        houseno: houseno,
                        contactno: contactno))),
              );
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
