import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Resident {
  static const ROOT = "http://lrgs.ftsm.ukm.my/users/a159159/getResident.php";
  static const GET_RESIDENT_ACTION = "GET_RESIDENT";
  static const VIEW_RESIDENT_ACTION = "VIEW_RESIDENT";
  static const ADD_RESIDENT_ACTION = "ADD_RESIDENT";
  static const UPDATE_RESIDENT_ACTION = 'UPDATE_RESIDENT';
  static const DELETE_RESIDENT_ACTION = 'DELETE_RESIDENT';

  static Future<List> viewData() async {
    var map = Map<String, dynamic>();

    map['action'] = VIEW_RESIDENT_ACTION;
    final response = await http.post(ROOT, body: map);
    // List<Residents> list = parseResidents(response.body);

    // return list;

    return json.decode(response.body);
  }

  static Future<List> addData(String name, String roadno, String houseno,
      String contactno, String count) async {
    var map = Map<String, dynamic>();

    // String residentid = "Surada215";

    map['action'] = ADD_RESIDENT_ACTION;
    map['name'] = name;
    map['roadno'] = roadno;
    map['houseno'] = houseno;
    map['contactno'] = contactno;
    map['count'] = count;

    final response = await http.post(ROOT, body: map);
    return json.decode(response.body);
  }

  static Future<List> updateData(String rid, String name, int roadno,
      String houseno, String contactno) async {
    var map = Map<String, dynamic>();

    map['action'] = UPDATE_RESIDENT_ACTION;
    map['residentid'] = rid;
    map['name'] = name;
    map['roadno'] = roadno;
    map['houseno'] = houseno;
    map['contactno'] = contactno;

    final response = await http.post(ROOT, body: map);

    return json.decode(response.body);
  }

  static Future<List> deleteData(String rid) async {
    var map = Map<String, dynamic>();

    map['action'] = DELETE_RESIDENT_ACTION;
    map['residentid'] = rid;

    final response = await http.post(ROOT, body: map);

    return json.decode(response.body);
  }
}
