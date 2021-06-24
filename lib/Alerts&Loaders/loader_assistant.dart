import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/Asstant_hoem_page.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Assistants.dart';
class loader_assistant extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<loader_assistant> {
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
        builder: (context) => assistant_homepage()
    )
    );
  }

  initScreen(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffFBB97C),
      body: Column(
        children: [
          Center(
            child: SpinKitDoubleBounce(
              color: Colors.white,
              size: 60.0,


            ),

          ),
          Center(child: Row(
            children: [
              Text('Assistant Created Succesfully',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
              Icon(Icons.check_circle_rounded,color:Color(0xffFBB97C) ,)
            ],
          ))
        ],
      ),
    );
  }
}