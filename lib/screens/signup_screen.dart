import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../animation/FadeAnimation.dart';

import 'login_screen.dart';
import '../db/user_db.dart';
import '../db/resident_db.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MySignupScreen(),
    );
  }
}

class MySignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<MySignupScreen> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController levelController = new TextEditingController();

  // TextEditingController residController = new TextEditingController();
  TextEditingController contactnoController = new TextEditingController();
  TextEditingController roadnoController = new TextEditingController();
  TextEditingController housenoController = new TextEditingController();

  TextEditingController action = new TextEditingController();

  // Repository().placeAddApiProvider(int.parse(roadnoController.text))
  // var roadno = int.parse(roadnoController.text);

  int selectedRadio = 0;
  String level = '';
  String result = '';
  // String lastid = '';

  // Future<List> getLastId() async{
    
  //   var map = Map<String, dynamic>();

  //   final response = await http.post('http://lrgs.ftsm.ukm.my/users/a159159/lastresidentid.php', body: map);
    
  //   return jsonDecode(response.body);
  //   // print(data.toString());
  // }

  // addId(getLastId()){
  //   String residentid = getLastId();

  //   String subresidentid = residentid.substring(6);
  //   int intresidentid = int.parse(subresidentid);
  //   intresidentid = intresidentid + 1;
  //   // String strresidentid = intresidentid.toString();

  //   // String newresidentid = "Surada" + strresidentid;

  //   lastid = residentid;
  // }

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;

      if (selectedRadio == 1) {
        level = 'user';
        levelController.text = level;
      } else if (selectedRadio == 2) {
        level = 'admin';
        levelController.text = level;
      }
    });
  }

  addUser() {
    // int roadnum = int.parse(roadnoController.text);
    Resident.addData(nameController.text, roadnoController.text, housenoController.text,
            contactnoController.text)
        .then((result) {});
  }

  // checkEmptyFields() {
  //   if (nameController.text.isEmpty || addressController.text.isEmpty || usernameController.text.isEmpty ||
  //       passwordController.text.isEmpty || emailController.text.isEmpty || levelController.text.isEmpty ||
  //       contactnoController.text.isEmpty || roadnoController.text.isEmpty || housenoController.text.isEmpty) {
  //     print('Empty Fields');
  //     return;
  //   }
  // }

  msgToast() {
    Fluttertoast.showToast(
        msg: "Successfully Signed up!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  // Method to clear TextField values
  clearValues() {
    usernameController.text = '';
    passwordController.text = '';
    nameController.text = '';
    emailController.text = '';
    addressController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd8d8d8),
      // appBar: AppBar(
      //   backgroundColor: Colors.purple,
      //   title: Text('Sign Up'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      child: FadeAnimation(
                    1,
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/1.png"),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Text(
                      "Sign Up",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 30,
                        color: Color(0xff203354),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1,
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.transparent,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 50
                                ),
                                Align(
                                  alignment: Alignment(-0.9, 0.0),
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: Text(
                                      "Account Details",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: TextField(
                                controller: usernameController,
                                // textAlign: TextAlign.center,
                                style: new TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.person, color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Username",
                                  hintStyle: TextStyle(color: Colors.grey),
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                // textAlign: TextAlign.center,
                                style: new TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.lock, color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(top: 30),
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment(-0.9, 0.0),
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: Text(
                                      "Personal Details",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: TextField(
                                controller: nameController,
                                // textAlign: TextAlign.center,
                                style: new TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.person, color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Name",
                                  hintStyle: TextStyle(color: Colors.grey),
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: TextField(
                                controller: contactnoController,
                                // textAlign: TextAlign.center,
                                style: new TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.person, color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Contact Number",
                                  hintStyle: TextStyle(color: Colors.grey),
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: TextField(
                                controller: emailController,
                                // textAlign: TextAlign.center,
                                style: new TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.email, color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.grey),
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: TextField(
                                controller: addressController,
                                // textAlign: TextAlign.center,
                                style: new TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 50.0),
                                  prefixIcon: Icon(Icons.location_city,
                                      color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Address",
                                  hintStyle: TextStyle(color: Colors.grey),
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: TextField(
                                controller: roadnoController,
                                // keyboardType: TextInputType.number,
                                style: new TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.store_mall_directory,
                                      color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Road Number",
                                  hintStyle: TextStyle(color: Colors.grey),
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: TextField(
                                controller: housenoController,
                                // textAlign: TextAlign.center,
                                style: new TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.my_location,
                                      color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "House Number",
                                  hintStyle: TextStyle(color: Colors.grey),
                                )),
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(10.0),
                          //   child: TextField(
                          //       controller: residController,
                          //       // textAlign: TextAlign.center,
                          //       style: new TextStyle(
                          //         color: Colors.black,
                          //       ),
                          //       decoration: InputDecoration(
                          //         prefixIcon: Icon(Icons.settings,
                          //             color: Colors.grey),
                          //         border: OutlineInputBorder(
                          //             borderRadius: BorderRadius.all(
                          //                 Radius.circular(10.0)),
                          //             borderSide:
                          //                 BorderSide(color: Colors.green)),
                          //         filled: true,
                          //         fillColor: Colors.white,
                          //         hintText: "Resident ID",
                          //         hintStyle: TextStyle(color: Colors.grey),
                          //       )),
                          // ),
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
                                        Text('User',
                                            style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .display1,
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
                                        Text('Admin',
                                            style: GoogleFonts.roboto(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .display1,
                                              fontSize: 16,
                                            )),
                                      ],
                                    )
                                  ]))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  FadeAnimation(
                      1,
                      new InkWell(
                        onTap: () {
                          addUser();
                          // addResident();
                          msgToast();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: new Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(49, 39, 79, 1),
                          ),
                          child: Center(
                            child: Text(
                              "Signup",
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      )),
                  FadeAnimation(
                    1,
                    Center(
                        child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account?',
                          style: GoogleFonts.montserrat(color: Colors.black54),
                          children: <TextSpan>[
                            TextSpan(
                                text: '  Login',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                    );
                                  },
                                style: GoogleFonts.montserrat(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
