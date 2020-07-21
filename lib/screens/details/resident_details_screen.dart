import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp4/screens/details/vehicle_details_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../db/vehicle_db.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

String vid, brand, type, regisdate, pic;

// ignore: must_be_immutable
class ResidentDetails extends StatelessWidget {
  final String residentid, name, roadno, houseno, contactno;

  ResidentDetails({
    Key key,
    this.residentid,
    this.name,
    this.roadno,
    this.houseno,
    this.contactno,
  }) : super(key: key);

  List vehicle = [];

  Future<List> getVehicle() async {
    final response = await http.post(
        "http://lrgs.ftsm.ukm.my/users/a159159/selectedVehicle.php",
        body: {"residentid": residentid});

    var dataResident = json.decode(response.body);
    return dataResident;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: new Text("Details")),
        backgroundColor: Color(0xff21254A),
        body: Center(
            child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Align(
              alignment: Alignment(-0.85, 0.2),
              child: Text("Owner's Details",
                  style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment(-0.55, 0.2),
              child: Text("Name : " + name,
                  style: GoogleFonts.montserrat(
                      fontSize: 16, color: Colors.white)),
            ),
            Align(
              alignment: Alignment(-0.85, 0.2),
              child: Text("House Number : " + houseno,
                  style: GoogleFonts.montserrat(
                      fontSize: 16, color: Colors.white)),
            ),
            Align(
              alignment: Alignment(-0.85, 0.2),
              child: Text("Road Number : " + roadno,
                  style: GoogleFonts.montserrat(
                      fontSize: 16, color: Colors.white)),
            ),
            Align(
              alignment: Alignment(-0.84, 0.2),
              child: Text("Contact Number : " + contactno ?? "not specified",
                  style: GoogleFonts.montserrat(
                      fontSize: 16, color: Colors.white)),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment(-0.85, 0.2),
              child: Text("Vehicle's Details",
                  style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 15),
            Expanded(
              child: SizedBox(
                  height: 100.0,
                  child: FutureBuilder<List>(
                      future: getVehicle(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        return snapshot.hasData
                            ? new ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, i) {
                                  vehicle = snapshot.data;

                                  return new Container(
                                    padding: const EdgeInsets.all(0.1),
                                    child: new GestureDetector(
                                      onTap: () {
                                        vid = vehicle[i]['VehicleId'];
                                        brand = vehicle[i]['VehicleBrand'];
                                        type = vehicle[i]['VehicleType'];
                                        regisdate =
                                            vehicle[i]['RegistrationDate'];
                                        pic = vehicle[i]['VehiclePicture'];
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VehicleDetails(
                                                      residentid: residentid,
                                                      vid: vid,
                                                      brand: brand,
                                                      type: type,
                                                      regisdate: regisdate,
                                                      pic: pic,
                                                      name: name,
                                                      roadno: roadno,
                                                      houseno: houseno,
                                                      contactno: contactno)),
                                        );
                                      },
                                      child: new Card(
                                        color: Color(455561),
                                        child: new ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                          leading: new CircleAvatar(
                                            radius: 30.0,
                                            backgroundImage: NetworkImage(
                                                "http://lrgs.ftsm.ukm.my/users/a159159/${vehicle[i]['VehiclePicture']}"),
                                            backgroundColor: Colors.transparent,
                                          ),
                                          title: new Text(
                                              vehicle[i]['VehicleBrand'],
                                              style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17))),
                                          subtitle: new Text(
                                            "Plate Number : ${vehicle[i]['VehicleId']}",
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
                            : Text("none");
                      })),
            ),
          ],
        )));
  }
}
