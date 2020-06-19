import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VehicleDetails extends StatelessWidget {
  final String residentid, vid, brand, type, regisdate, pic, name, roadno, houseno, contactno;

  VehicleDetails(
      {Key key,
      this.residentid,
      this.vid,
      this.brand,
      this.type,
      this.regisdate,
      this.pic,
      this.name,
      this.roadno,
      this.houseno,
      this.contactno})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: new Text("Details")),
        backgroundColor: Color(0xff21254A),
        body: Column(
          children: <Widget>[
            Center(
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.1), BlendMode.dstATop),
                    image: new NetworkImage(
                      'http://lrgs.ftsm.ukm.my/users/a159159/' + pic,
                    ),
                  ),
                ),
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  CircleAvatar(
                      backgroundImage: NetworkImage(
                        'http://lrgs.ftsm.ukm.my/users/a159159/' + pic,
                      ),
                      radius: 70.0),
                  SizedBox(
                    height: 20,
                  ),
                  Text(brand + " (" + type + ")",
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(vid,
                      style: GoogleFonts.montserrat(
                          fontSize: 15, color: Colors.white)),
                ]),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment(-0.85, 0.2),
              child: Text(
                        "Owner's Details",
                        style: GoogleFonts.montserrat(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)
              ),
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment(-0.6, 0.2),
              child: Text(
                        name,
                        style: GoogleFonts.montserrat(fontSize: 16, color: Colors.white)
              ),
            ),
            Align(
              alignment: Alignment(-0.85, 0.2),
              child: Text(
                        "House Number : " + houseno,
                        style: GoogleFonts.montserrat(fontSize: 16, color: Colors.white)
              ),
            ),
            Align(
              alignment: Alignment(-0.85, 0.2),
              child: Text(
                        "Road Number : " + roadno,
                        style: GoogleFonts.montserrat(fontSize: 16, color: Colors.white)
              ),
            ),
            Align(
              alignment: Alignment(-0.84, 0.2),
              child: Text(
                        "Contact Number : " + contactno??"not specified",
                        style: GoogleFonts.montserrat(fontSize: 16, color: Colors.white)
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment(-0.85, 0.2),
              child: Text(
                        "Car's Details",
                        style: GoogleFonts.montserrat(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment(-0.78, 0.2),
              child: Text(
                        "Number Plate : " + vid??"not specified",
                        style: GoogleFonts.montserrat(fontSize: 16, color: Colors.white)
              ),
            ),
            Align(
              alignment: Alignment(-0.83, 0.2),
              child: Text(
                        "Brand : " + brand??"not specified",
                        style: GoogleFonts.montserrat(fontSize: 16, color: Colors.white)
              ),
            ),
            Align(
              alignment: Alignment(-0.87, 0.2),
              child: Text(
                        "Class : " + type??"not specified",
                        style: GoogleFonts.montserrat(fontSize: 16, color: Colors.white)
              ),
            ),
            Align(
              alignment: Alignment(-0.76, 0.2),
              child: Text(
                        "Registration Date : " + regisdate??"not specified",
                        style: GoogleFonts.montserrat(fontSize: 16, color: Colors.white)
              ),
            ),
          ],
        ));
  }
}
