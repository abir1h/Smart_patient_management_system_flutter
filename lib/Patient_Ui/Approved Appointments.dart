import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_patientmanagement_system/Alerts&Loaders/check_seraial%20Loader.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/see%20patients.dart';
import 'package:smart_patientmanagement_system/Patient_Ui/Appointments.dart';
import 'package:smart_patientmanagement_system/Patient_Ui/Check_Serial.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';
class approved_appointments extends StatefulWidget {
  @override
  _approved_appointmentsState createState() => _approved_appointmentsState();
}

class _approved_appointmentsState extends State<approved_appointments> {
  navigate(DocumentSnapshot info){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>check_serial_loader(info: info,)));
  }
  AuthService _auth=AuthService();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var heigth= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    final User user = auth.currentUser;
    final uid = user.uid;
    return  SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Approved Appointments"),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>appointments()));
        }),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Appointment_History').
              doc(uid).
              collection('appointments')
                  .where('Patient_uid' ,isEqualTo: uid).where('Status',isEqualTo: '1').snapshots(),
              builder: (context,snapshot){
                if(snapshot.hasData){

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context,index){
                        DocumentSnapshot data = snapshot.data.docs[index];
                        return ListTile(

                          minVerticalPadding: 10,
                          trailing: Column(
                            children: [
                              SizedBox(height: heigth/30 ,),
                              Text('Approved'.toUpperCase(),style: GoogleFonts.lato(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ))
                            ],
                          ),

                          title: Text(data['description'],style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black),),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Appointment Request To  Dr.' + data['Doctor Name'],style: GoogleFonts.lato(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ) ),
                              Text('On '+ data['Date'],style: GoogleFonts.lato(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),),
                              Center(child: ElevatedButton.icon(onPressed: (){

                                navigate(data);
                              }, icon: Icon(Icons.dock_sharp), label: Text('Check Serial')))
                            ],
                          ),
                        );
                      });
                }return CircularProgressIndicator();
              })
        ],
      ),
    ));
  }
}
