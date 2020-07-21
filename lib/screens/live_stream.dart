import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

import 'details/check_register.dart';

class LiveScreen extends StatefulWidget {
  @override
  _LiveScreenState createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  final String urlToStreamVideo = 'http://213.226.254.135:91/mjpg/video.mjpg';
  final VlcPlayerController controller = VlcPlayerController();
  TextEditingController plate = new TextEditingController();

  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  String noplate = "None";

  bool play = false;
  bool play2 = false;

  Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        camera: _cameraOcr,
        waitTap: true,
      );

      setState(() {
        noplate = texts[0].value;
        plate.text = noplate;
      });
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Live View"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh, color: Colors.white),
                onPressed: () {
                  setState(() {
                    if (play == true) {
                      play = false;
                    } else {
                      play = true;
                    }
                  });
                })
          ],
        ),
        backgroundColor: Color(0xff21254A),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                color: Colors.deepPurple,
                width: double.maxFinite,
                height: 280,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    VlcPlayer(
                        aspectRatio: play ? 16 / 9 : 21 / 9,
                        url: urlToStreamVideo,
                        controller: controller,
                        placeholder:
                            Center(child: CircularProgressIndicator())),
                    SizedBox(height: 12),
                  ],
                )),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                  controller: plate,
                  onChanged: (value) {
                    setState(() {
                      noplate = value;
                    });
                  },
                  // textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.green)),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Plate Number",
                    hintStyle: TextStyle(color: Colors.grey),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 175.0,
                  height: 50.0,
                  child: RaisedButton(
                      color: Colors.purple,
                      onPressed: _read,
                      child: Text('Scan using Camera',
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
                          Fluttertoast.showToast(
                              msg: "Search for " + noplate,
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontSize: 16.0);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    (CheckScreen(noplate: noplate))),
                          );
                        },
                        child: Text('Check Plate',
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))))
              ],
            )
          ],
        )));
  }
}
