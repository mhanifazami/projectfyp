import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../animation/FadeAnimation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:convert';
import 'main_screen.dart';
import 'signup_screen.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login PHP My Admin',
      home: new MyLoginScreen(),
      routes: <String, WidgetBuilder>{
        '/AdminPage': (BuildContext context) => new MainScreen(),
        '/LoginScreen': (BuildContext context) => new LoginScreen(),
      },
    );
  }
}

class MyLoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<MyLoginScreen> {
  final usernameController = new TextEditingController();
  final passwordController = new TextEditingController();

  String msg = '';

  Future<List> _login() async {
    final response = await http
        .post("http://lrgs.ftsm.ukm.my/users/a159159/loginUser.php", body: {
      "username": usernameController.text,
      "password": passwordController.text,
    });

    var datauser = json.decode(response.body);
    // print("fld_username_ezcam");

    if (datauser.length == 0) {
      setState(() {
        msg = "Login Fail";
      });
    } 
    else {
      if (datauser[0]['fld_level_ezcam'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/AdminPage');
      } else if (datauser[0]['fld_level_ezcam'] == 'user') {
        Navigator.pushReplacementNamed(context, '/AdminPage');
      }

      Fluttertoast.showToast(
        msg: "Welcomo",
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black45,
      );
    }

    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff21254A),
      body: Column(
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
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(
                  1,
                  Text(
                    "Login",
                    style: GoogleFonts.montserrat(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
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
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                            controller: usernameController,
                            style: new TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.person, color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.green)),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Username",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              style: new TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.grey),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: Colors.green)),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                FadeAnimation(
                    1,
                    new InkWell(
                      onTap: () {
                        _login();
                      //   Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => MainScreen()),
                      // );
                        // print(passwordController.text);
                      },
                      child: new Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 60),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.deepPurple,
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 2.0,
                ),
                FadeAnimation(
                  1,
                  Center(
                      child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                    child: RichText(
                        text: TextSpan(
                          text: 'New here?',
                          style: GoogleFonts.montserrat(color: Colors.white70),
                          children: <TextSpan>[
                            TextSpan(
                                text: '  Create an account',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignupScreen()),
                                    );
                                  },
                                style: GoogleFonts.montserrat(
                                  color: Colors.pink[200],
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                  )),
                ),
                // Center(
                //   child: Text(
                //     "Already have an account?",
                //   ),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
