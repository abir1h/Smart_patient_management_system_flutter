
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

import 'Assistant_add_patient_auto.dart';
import 'Asstant_hoem_page.dart';
import 'Mannualy_add_patient.dart';
class Addpatient_dialog extends StatefulWidget {

  @override
  _Addpatient_dialogState createState() => _Addpatient_dialogState();
}

class _Addpatient_dialogState extends State<Addpatient_dialog> {
  NavigateData(DocumentSnapshot info){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Assistant_add_patient(assistantinfo: info,)));
  }NavigatemannuData(DocumentSnapshot info){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Mannualy_add_patient(info: info,)));
  }
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;
    final uid = user.uid;
    return SafeArea(child:
         Scaffold(
          appBar:
            AppBar(
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
         body: StreamBuilder<DocumentSnapshot>(
           stream:  FirebaseFirestore.instance.collection('Doctor_Asistants').doc(uid).snapshots(),
           builder: (context, snapshot) {
             if(snapshot.hasData){
               DocumentSnapshot Data= snapshot.data;
               return Padding(
                 padding: const EdgeInsets.only(left: 30.0),
                 child: Column(mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,

                   children: [
                     ElevatedButton.icon(

                         onPressed: (){
                           NavigateData(Data);
                         }, icon: Icon(Icons.person_add), label: Text('Add Patient through out the app',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 20),)),
                     SizedBox(height: 20,),
                     ElevatedButton.icon(

                         onPressed: (){
                           NavigatemannuData(Data);
                         }, icon: Icon(Icons.person_add), label: Text('Add patient Mannualy',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 20),)),
                   ],
                 ),
               );
             }else{
               return Text('No Data available');
             }
           }
         ),

        )

    );
  }
}
