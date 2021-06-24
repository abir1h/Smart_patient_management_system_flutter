import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/Doctor_info.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';
class DI_laoder extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<DI_laoder> {
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthService _auth=AuthService();
  DocumentSnapshot Data;
  NavigateData(DocumentSnapshot info){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Doctor_info(info: info)));
  }
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
    var duration = Duration(seconds: 1);
    return new Timer(duration, route);
  }

  route() {
   NavigateData(Data);

  }

  initScreen(BuildContext context) {
    final User user = auth.currentUser;
    final uid = user.uid;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('Doctor_Asistants').doc(uid).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          Data= snapshot.data;
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SpinKitFadingFour(
                color: Colors.blue,
                size: 50.0,

              ),
            ),
          );
        }else{
          return Center(child: Text("You have not assigned yet!"));
        }
      }
    );
  }
}