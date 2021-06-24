import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/Asstant_hoem_page.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

import 'Assistant_patients.dart';
class seepatients extends StatefulWidget {
  @override
  _seepatientsState createState() => _seepatientsState();
}

class _seepatientsState extends State<seepatients> {
  NavigateData(DocumentSnapshot info){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Assistant_patients(info: info,)));
  }
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;
    final uid = user.uid;
    return SafeArea(child: StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('Doctor_Asistants').doc(uid).snapshots(),
      builder: (context, snapshot) {
        DocumentSnapshot Data= snapshot.data;
        return Scaffold(
          appBar:  AppBar(
            backgroundColor: Colors.blue,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => assistant_homepage()));
                }),
            title: Text(
              'Patients'.toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
            ),
          ),
          body:Padding(
            padding: const EdgeInsets.only(left:150.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,

              children: [
                ElevatedButton.icon(

                    onPressed: (){
                  NavigateData(Data);
                }, icon: Icon(Icons.group), label: Text('See Patients',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 20),))
              ],
            ),
          ),
        );
      }
    )
    );
  }
}
