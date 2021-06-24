import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_patientmanagement_system/Patient_Ui/Check_Serial.dart';
class check_serial_loader extends StatefulWidget {
  DocumentSnapshot info;
  check_serial_loader({this.info});
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State< check_serial_loader> {
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
Navigate(DocumentSnapshot info){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Check_serial(info: info,)));

}
  route() {
   Navigate(widget.info);
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
