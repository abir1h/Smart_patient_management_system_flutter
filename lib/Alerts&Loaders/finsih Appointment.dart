import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/manage_%20patients/Manage_Patients.dart';
class finish extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State< finish> {
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
        builder: (context) => Manage_patients()
    )
    );
  }

  initScreen(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.only(top: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitChasingDots(
              color: Colors.white,
              size: 100.0,

            ),SizedBox(height: 15,),
            Center(child: Text("Please Wait...".toUpperCase(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900,color: Colors.white),))
          ],
        ),
      ),
    );
  }
}
