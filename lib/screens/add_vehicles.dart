import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp4/screens/vehicle_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../db/vehicle_db.dart';
import '../db/resident_db.dart';

int count = 0;

class AddVehicle extends StatefulWidget {
  @override
  _MyAddVehicleState createState() => _MyAddVehicleState();
}

class _MyAddVehicleState extends State<AddVehicle> {
  TextEditingController plate = new TextEditingController();
  TextEditingController brand = new TextEditingController();
  TextEditingController type = new TextEditingController();

  List name = List();

  int selectedRadio = 0;
  String classVehicle = "";
  String pickeddate = "";

  String residentid;
  bool entername = false;
  DateTime _dateTime;

  Future<String> getResident() async {
    final response = await http
        .get("http://lrgs.ftsm.ukm.my/users/a159159/getResidentId.php");
    var listData = json.decode(response.body);
    setState(() {
      name = listData;
    });
    return "Success";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getResident();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;

      if (selectedRadio == 1) {
        classVehicle = "Car";
        brand.text = classVehicle;
      } else if (selectedRadio == 2) {
        classVehicle = "Motorcycle";
        brand.text = classVehicle;
      } else if (selectedRadio == 3) {
        classVehicle = "Lorry";
        brand.text = classVehicle;
      }
    });
  }

  checkEmpty() {
    if (residentid.isEmpty ||
        plate.text.isEmpty ||
        type.text.isEmpty ||
        classVehicle.isEmpty ||
        pickeddate.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please fill in all the information!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    } else {
      addVehicle();
      Fluttertoast.showToast(
          msg: "Successfully Register Vehicle!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => (VehicleRecordScreen())),
      );
    }
  }

  clearValues() {
    plate.clear();
    brand.clear();
    type.clear();
  }

  addVehicle() {
    count++;
    Vehicle.addData(residentid, plate.text, type.text, classVehicle, pickeddate,
        count.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
          title: new Text("Add Vehicle"), backgroundColor: Colors.purple),
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
                DropdownButton(
                  hint: Text("Select Owner Name",
                      style: GoogleFonts.montserrat(
                          fontSize: 16, color: Colors.white30)),
                  items: name.map((item) {
                    return new DropdownMenuItem(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.person),
                          Text(item['Name'],
                              style:
                                  GoogleFonts.montserrat(color: Colors.black))
                        ],
                      ),
                      value: item['ResidentId'],
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      residentid = newVal;
                    });
                  },
                  value: residentid,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                      controller: plate,
                      // textAlign: TextAlign.center,
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
                        hintText: "Number Plate",
                        hintStyle: TextStyle(color: Colors.grey),
                      )),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                      controller: type,
                      // textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.directions_car, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.green)),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Vehicle Name",
                        hintStyle: TextStyle(color: Colors.grey),
                      )),
                ),
                SizedBox(height: 20),
                Column(
                  children: <Widget>[
                    SizedBox(width: 15),
                    Text(_dateTime == null ? 'Please select date' : pickeddate,
                        style: GoogleFonts.montserrat(
                            color: Colors.white, fontSize: 16)),
                    SizedBox(height: 20),
                    ButtonTheme(
                      minWidth: 370.0,
                      height: 50,
                      child: RaisedButton.icon(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2001),
                                    lastDate: DateTime(2021))
                                .then((date) {
                              setState(() {
                                _dateTime = date;
                                pickeddate =
                                    _dateTime.toString().substring(0, 10);
                              });
                            });
                          },
                          color: Colors.purple,
                          icon: Icon(Icons.calendar_today, color: Colors.white),
                          label: Text('Select date',
                              style: GoogleFonts.montserrat(
                                  color: Colors.white, fontSize: 16))),
                    )
                  ],
                ),
                Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Radio(
                                value: 1,
                                groupValue: selectedRadio,
                                activeColor: Colors.deepPurple,
                                onChanged: (val) {
                                  setSelectedRadio(val);
                                },
                              ),
                              Text('Car',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 16,
                                  )),
                              Padding(
                                padding: new EdgeInsets.all(10.0),
                              ),
                              Radio(
                                value: 2,
                                groupValue: selectedRadio,
                                activeColor: Colors.deepPurple,
                                onChanged: (val) {
                                  setSelectedRadio(val);
                                },
                              ),
                              Text('Motorcycle',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 16,
                                  )),
                              Radio(
                                value: 3,
                                groupValue: selectedRadio,
                                activeColor: Colors.deepPurple,
                                onChanged: (val) {
                                  setSelectedRadio(val);
                                },
                              ),
                              Text('Lorr',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 16,
                                  )),
                            ],
                          )
                        ])),
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
