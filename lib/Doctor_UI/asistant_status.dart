
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_patientmanagement_system/Alerts&Loaders/Loader_assistant_add.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Assistants.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/patients.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

import 'Auto_add_assistant.dart';
import 'Dashboard.dart';

class add_assistant extends StatefulWidget {
  DocumentSnapshot info;
  add_assistant({this.info});
  @override
  _add_assistantState createState() => _add_assistantState();
}

class _add_assistantState extends State<add_assistant> {

  @override
  Widget build(BuildContext context) {
    String assistant_uid= widget.info.data()['Assistant_uid'];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Assistants()));
            }),
        backgroundColor: Colors.blue,
        title: Center(child: Text('Add Assistant')),
      ),
      body:Center(
        child: Stack(
          children: [
            Container(

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  SizedBox(height: 100,),
                  Text(
                    'Are You Sure?',
                    style: TextStyle(
                        fontSize: 26,fontWeight: FontWeight.w700

                    ),

                  ),
                  SizedBox(height: 16,),
                  Text('You want to add this Assistant',style: TextStyle(fontSize: 16),),
                  SizedBox(height: 24,),
                  Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(onPressed: (){
                          addpatient(widget.info,assistant_uid);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>assistant_add_loader()));

                        }, child: Text('YES'.toUpperCase(),style: TextStyle(fontWeight:FontWeight.w700,fontSize: 25),)),

                        SizedBox(width: 200,),
                        TextButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Dashboard()));
                        }, child: Text('No'.toUpperCase(),style: TextStyle(fontWeight:FontWeight.w700,fontSize: 25),)),
                      ],
                    ),
                  )

                ],
              ),
              padding: EdgeInsets.only(
                  top: 100,
                  left: 16,right: 16,bottom: 16
              ),
              margin: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(17),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,

                    )
                  ]
              ),
            ),
            Positioned(

                top: 0,
                left: 16,
                right: 16,
                child: Center(
                    child: ClipOval(
                      child: Container(
                        height: 150,
                        width: 150,
                        color: Colors.grey.shade200,
                        child: Image.asset(
                          'images/question.png',
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                )

            )
          ],
        ),
      ),
    );
  }
}

Future addpatient(DocumentSnapshot info,String assistant_uid) async {
  final AuthService _auth = AuthService();
  List<String> splitlist = info.data()['Assistant Name'].split(' ');
  List<String> indexlist = [];
  for (int i = 0; i < splitlist.length; i++) {
    for (int j = 0; j <= splitlist[i].length + i; j++) {
      indexlist.add(splitlist[i].substring(0, j).toLowerCase());
    }
  }
  final uid = await _auth.getCurrenbtUid();
  FirebaseFirestore.instance
      .collection('Doctor_Asistants').doc(assistant_uid)
      .set({
    'Assistant Name': info.data()['Assistant Name'],
    'Gender': info.data()['Gender'],
    'About': info.data()['About'],
    'Email': info.data()['Email'],
    'Experience': info.data()['Experience'],
    'Mobile': info.data()['Mobile'],
    'Age': info.data()['Age'],
    'Assistant Address': info.data()['Assistant Address'],
    'Assistant_uid': info.data()['Assistant_uid'],
    'Doctor_uniqueid': uid,

    'Created_at': FieldValue.serverTimestamp(),
    'searchindex': indexlist,
  });
}