import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_patientmanagement_system/wrapper.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds:5);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => wrapper()));
  }

  initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'Smart Patient\nManagement\n  System',
                style: TextStyle(
                    fontFamily: 'potta',
                    fontSize: 43,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, shadows: [

                ]),
              ),
            ),
            SpinKitThreeBounce(
              size: 70,
              color: Colors.white,
            ),

          ],
        ),
      ),
    );
  }
}