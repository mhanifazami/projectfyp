import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class User {
  static const ROOT = "http://lrgs.ftsm.ukm.my/users/a159159/getUser.php";
  static const VIEW_USER_ACTION = "VIEW_USER";
  static const ADD_USER_ACTION = "ADD_USER";
  static const UPDATE_USER_ACTION = 'UPDATE_USER';
  static const DELETE_USER_ACTION = 'DELETE_USER';

  static Future<List> viewData() async {
    var map = Map<String, dynamic>();

    map['action'] = VIEW_USER_ACTION;
    final response = await http.post(ROOT, body: map);

    return json.decode(response.body);
  }

  static Future<List> addData(
      String name, String address, String username, String password, String email, String level) async {
    var map = Map<String, dynamic>();

    map['action'] = ADD_USER_ACTION;
    map['name'] = name;
    map['address'] = address;
    map['username'] = username;
    map['password'] = password;
    map['email'] = email;
    map['level'] = level;

    final response = await http.post(ROOT, body: map);
    // print('user added Response: ${response.body}');

    return json.decode(response.body);
  }

  // static Future<List> updateData(String rid, String name, int roadno,
  //     String houseno, String contactno) async {
  //   var map = Map<String, dynamic>();

  //   map['action'] = UPDATE_USER_ACTION;
  //   map['Residentid'] = rid;
  //   map['Name'] = name;
  //   map['RoadNo'] = roadno;
  //   map['HouseNo'] = houseno;
  //   map['ContactNo'] = contactno;

  //   final response = await http.post(ROOT, body: map);

  //   return json.decode(response.body);
  // }
}