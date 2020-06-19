import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Vehicle {
  static const ROOT = "http://lrgs.ftsm.ukm.my/users/a159159/getVehicle.php";
  static const VIEW_VEHICLE_ACTION = 'VIEW_VEHICLE';
  static const ADD_VEHICLE_ACTION = 'ADD_VEHICLE';
  static const UPDATE_VEHICLE_ACTION = 'UPDATE_VEHICLE';
  static const DELETE_VEHICLE_ACTION = 'DELETE_VEHICLE';

  static Future<List> viewData() async {
    
    var map = Map<String, dynamic>();

    map['action'] = VIEW_VEHICLE_ACTION;
    final response = await http.post(ROOT, body: map);
    // List<Residents> list = parseResidents(response.body);

    // return list;

    return json.decode(response.body);
  }

  // static Future<List> addData(
  //     String name, int roadno, String houseno, String contactno) async {
  //   var map = Map<String, dynamic>();

  //   map['action'] = ADD_RESIDENT_ACTION;
  //   map['Name'] = name;
  //   map['RoadNo'] = roadno;
  //   map['HouseNo'] = houseno;
  //   map['ContactNo'] = contactno;

  //   final response = await http.post(ROOT, body: map);

  //   return json.decode(response.body);
  // }

  // static Future<List> updateData(String rid, String name, int roadno,
  //     String houseno, String contactno) async {
  //   var map = Map<String, dynamic>();

  //   map['action'] = UPDATE_RESIDENT_ACTION;
  //   map['Residentid'] = rid;
  //   map['Name'] = name;
  //   map['RoadNo'] = roadno;
  //   map['HouseNo'] = houseno;
  //   map['ContactNo'] = contactno;

  //   final response = await http.post(ROOT, body: map);

  //   return json.decode(response.body);
  // }

  // static Future<List> deleteData(String rid) async {
  //   var map = Map<String, dynamic>();

  //   map['action'] = DELETE_RESIDENT_ACTION;
  //   map['Residentid'] = rid;

  //   final response = await http.post(ROOT, body: map);

  //   return json.decode(response.body);
  // }
}