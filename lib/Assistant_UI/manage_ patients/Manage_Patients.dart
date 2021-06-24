import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/manage_%20patients/Appointment%20Requsts.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

import '../Asstant_hoem_page.dart';
import 'Manage_appointments.dart';
class Manage_patients extends StatefulWidget {
  @override
  _Manage_patientsState createState() => _Manage_patientsState();
}

class _Manage_patientsState extends State<Manage_patients> {
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthService _auth=AuthService();
  NavigateData(DocumentSnapshot info){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Appointment_requsts(info: info,)));
  }NavigateData2(DocumentSnapshot info){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Manageappointments(info: info,)));
  }
  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;
    final uid = user.uid;
    var heigth= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return SafeArea(child: StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('Doctor_Asistants').doc(uid).snapshots(),
      builder: (context, snapshot) {
        DocumentSnapshot data=snapshot.data;
        return Scaffold(
          appBar:  AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text("Manage Patients",style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ) ),
            leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>assistant_homepage()));
            }),
          ),
          body: Column(
            children: [
              Center(
                child: Container(
              child: Container(
                      child: Image(
                      image: AssetImage('images/patientM.jpg'),
                      height: heigth/2,
                    )
                ),
              )
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    primary: Colors.blue,
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: (){
                    NavigateData(data);
                  }, child: Text('Appointment Requests', style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),)  )
              ,SizedBox(height: heigth/15,),ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    primary: Colors.blue,
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: (){
                    NavigateData2(data);
                  }, child: Text('Manage Appointments', style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),)  )
            ],
          ),
        );
      }
    ));
  }
}
