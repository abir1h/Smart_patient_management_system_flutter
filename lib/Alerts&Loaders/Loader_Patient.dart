import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Dashboard.dart';
import 'package:smart_patientmanagement_system/Patient_Ui/Homepage.dart';
class Loader_patient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<Loader_patient> {
  var a=8;
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
    var duration = Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Dashboard()
    )
    );
  }

  initScreen(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 60.0,

        ),
      ),
    );
  }
}
