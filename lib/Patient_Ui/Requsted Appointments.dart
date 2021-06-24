import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

import 'Appointments.dart';
class Requsted_appointments extends StatefulWidget {
  @override
  _Requsted_appointmentsState createState() => _Requsted_appointmentsState();
}

class _Requsted_appointmentsState extends State<Requsted_appointments> {
  AuthService _auth=AuthService();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var heigth= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    final User user = auth.currentUser;
    final uid = user.uid;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Pending Approval Appointments",style: GoogleFonts.lato(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ) ),
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>appointments()));
        }),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Appointment_History').
            doc(uid).
            collection('appointments')
                .where('Patient_uid' ,isEqualTo: uid).where("Status",isEqualTo: '0').snapshots(),
              builder: (context,snapshot){
              if(!snapshot.hasData){
                return Text('No Results');
              }return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context,index){
                    DocumentSnapshot data = snapshot.data.docs[index];
                   print(data['Status']);
                    return ListTile(

                      isThreeLine: true,

                      minVerticalPadding: 10,
                      trailing: Status(data['Status'].toString()),

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
                          ),)
                        ],
                      ),
                    );
                  });
              })
        ],
      ),
    ));
  }

  Status(String status) {
    String Status='Cancelled';
    if(status==Status){
      return Text("Cancelled",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600,fontSize: 18),);
    }else if(status=='0'){
      return Text("Pending",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600,fontSize: 18),);
    }
  }
}
