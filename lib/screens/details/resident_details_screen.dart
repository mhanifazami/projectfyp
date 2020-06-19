import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../db/resident_db.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class ResidentDetails extends StatelessWidget {
  final String residentid, name, roadno, houseno, contactno, vid, brand, type, regisdate;

  ResidentDetails(
      {Key key,
      this.residentid,
      this.name,
      this.roadno,
      this.houseno,
      this.contactno,
      this.vid,
      this.brand,
      this.type,
      this.regisdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: new Text("Details")),
        backgroundColor: Color(0xff21254A),
        body: Column(
          children: <Widget>[
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
              alignment: Alignment(-0.55, 0.2),
              child: Text(
                        "Name : " + name,
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
            SizedBox(height: 15),
            Align(
              alignment: Alignment(-0.82, 0.2),
              child: Text(
                        "Brand : " + brand??"not specified",
                        style: GoogleFonts.montserrat(fontSize: 16, color: Colors.white)
              ),
            ),
            Align(
              alignment: Alignment(-0.81, 0.2),
              child: Text(
                        "Number Plate : " + vid??"not specified",
                        style: GoogleFonts.montserrat(fontSize: 16, color: Colors.white)
              ),
            ),
            Align(
              alignment: Alignment(-0.77, 0.2),
              child: Text(
                        "Registration Date : " + regisdate??"not specified",
                        style: GoogleFonts.montserrat(fontSize: 16, color: Colors.white)
              ),
            ),
          ],
        )
    );
  }
}
