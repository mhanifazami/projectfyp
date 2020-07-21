import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp4/screens/resident_list_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../db/resident_db.dart';

int count = 0;

class AddResident extends StatefulWidget {
  @override
  _MyAddResidentState createState() => _MyAddResidentState();
}

class _MyAddResidentState extends State<AddResident> {
  TextEditingController name = new TextEditingController();
  TextEditingController roadno = new TextEditingController();
  TextEditingController houseno = new TextEditingController();
  TextEditingController contactno = new TextEditingController();

  checkEmpty() {
    if (name.text.isEmpty ||
        roadno.text.isEmpty ||
        houseno.text.isEmpty ||
        houseno.text.isEmpty ||
        contactno.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please fill in all the information!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    } else {
      addResident();
      Fluttertoast.showToast(
          msg: "Successfully Register resident!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => (ResidentScreen())),
      );
    }
  }

  clearValues() {
    name.text = '';
    roadno.text = '';
    houseno.text = '';
    contactno.text = '';
  }

  addResident() {
    count++;
    Resident.addData(
        name.text, roadno.text, houseno.text, contactno.text, count.toString());
    print(count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
          title: new Text("Add Resident"), backgroundColor: Colors.purple),
      backgroundColor: Color(0xff21254A),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 50,
              bottom: 30,
            ),
            child: Center(
              child: Text("Please fill in the forms",
                  style: GoogleFonts.montserrat(color: Colors.white)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                      controller: name,
                      style: new TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.green)),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Name",
                        hintStyle: TextStyle(color: Colors.grey),
                      )),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                      controller: roadno,
                      // textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.store_mall_directory,
                            color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.green)),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Road Number",
                        hintStyle: TextStyle(color: Colors.grey),
                      )),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                      controller: houseno,
                      // textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.my_location, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.green)),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "House Number",
                        hintStyle: TextStyle(color: Colors.grey),
                      )),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                      controller: contactno,
                      // textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.contacts, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.green)),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Contact Number",
                        hintStyle: TextStyle(color: Colors.grey),
                      )),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 175.0,
                      height: 50.0,
                      child: RaisedButton(
                          color: Colors.purple,
                          onPressed: () {
                            checkEmpty();
                          },
                          child: Text('Add',
                              style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                    ),
                    SizedBox(width: 18),
                    ButtonTheme(
                        minWidth: 175,
                        height: 50.0,
                        child: RaisedButton(
                            color: Colors.deepPurpleAccent,
                            onPressed: () {
                              clearValues();
                            },
                            child: Text('Reset',
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
