import 'package:flutter/material.dart';
import 'package:light/light.dart';
import 'dart:async';

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
        _luxString = "It's as dark as my soul";
      else if (luxValue < 80)
        _luxString = "I can almost see your ugly face";
      else if (luxValue < 2000)
        _luxString = "Then there was light!";
      else if (luxValue < 4000)
        _luxString = "The sun is shining upon you :)";
      else
        _luxString = "IT'S TOO DAMN BRIGHT! MY EYES!!!!";
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
        appBar: new AppBar(
          title: const Text('WeLit'),
        ),
        body: new Center(
          child: new Text(_luxString),
        ),
      ),
    );
  }
}
