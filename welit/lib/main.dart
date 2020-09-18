import 'package:flutter/material.dart';
import 'package:light/light.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';


void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _luxString = 'Unknown';
  Light _light;
  StreamSubscription _subscription;

  void onData(int luxValue) async {
    print("Lux value: $luxValue");
    setState(() {
      if (luxValue < 10)
        _luxString = "IT IS AS DARK AS MY SOUL *sigh*";
      else if (luxValue < 80)
        _luxString = "UGH I CAN ALMOST SEE YOUR UGLY FACE";
      else if (luxValue < 2000)
        _luxString = "BRIGHTER THAN YOUR FUTURE XOXO";
      else if (luxValue < 4000)
        _luxString = "THE SUN IS SHINING UPON YOU :)";
      else
        _luxString = "IT'S TOO DAMN BRIGHT! MY EYES! MY EYESS!!";
    });
  }

  void stopListening() {
    _subscription.cancel();
  }

  void startListening() {
    _light = new Light();
    try {
      _subscription = _light.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    startListening();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 200, 10, 0),
              child: Center(child: Text(_luxString,
                textAlign: TextAlign.center,
                style:
                GoogleFonts.gloriaHallelujah(fontSize: 20, fontWeight: FontWeight.bold)
                ,)),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/cloud.png'),
                fit: BoxFit.fill,
              )
            ),
          ),
        ),
      ),
    );
  }
}


