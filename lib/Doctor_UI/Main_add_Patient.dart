

import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Add_patietn.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Auto_add_patietn.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/patient_detail.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/patients.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

import 'Dashboard.dart';

class main_add_patient extends StatefulWidget {
  @override
  _main_add_patientState createState() => _main_add_patientState();
}

class _main_add_patientState extends State<main_add_patient> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController Search_Controller = TextEditingController();
  String Search_String;
  final AuthService _auth = AuthService();

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;
    final uid = user.uid;

    Route_To_auto_add_patient(DocumentSnapshot info) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => auto_add_patient(
                    info: info,
                  )));
    }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Dashboard()));
            }),
        title: Text(
          'Patients'.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      Search_String = val.toLowerCase();
                    });
                  },
                  controller: Search_Controller,
                  decoration: InputDecoration(
                      hoverColor: Colors.blue,
                      prefixIcon: Icon(
                        Icons.search,
                        color:Colors.blue,
                        size: 30,
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(
                            Icons.clear_outlined,
                            color: Colors.blue,
                          ),
                          onPressed: () => Search_Controller.clear()),
                      hintText: 'Search Patient Name',
                      hintStyle:
                          TextStyle(color: Colors.blue, fontSize: 20)),
                ),
              ),
              Text('Patients Throughout the App',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  )),
            ],
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: (Search_String == null || Search_String.trim() == '')
                ? firestore.collection('Patients').snapshots()
                : firestore
                    .collection('Patients')
                    .where('searchindex', arrayContains: Search_String)
                    .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("We got an error! ${snapshot.error}");
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return SizedBox(
                    child: Center(
                      child: SpinKitThreeBounce(
                        size: 30,
                        color: Colors.orange,
                      ),
                    ),
                  );
                case (ConnectionState.none):
                  return Center(
                      child: Text(
                    "Opps! No data found.",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ));
                default:
                  return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: new ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot data = snapshot.data.docs[index];
                            return ListTile(
                             trailing: IconButton(icon: Icon(Icons.person_add,color:Colors.blue), onPressed: ()=> Route_To_auto_add_patient(data)),
                              leading: AvatarLetter(
                                size: 50,
                                backgroundColor: Colors.blueAccent,
                                textColor: Colors.black,
                                fontSize: 20,
                                upperCase: true,
                                numberLetters: 1,
                                letterType: LetterType.Circular,
                                text: data["Patient_Name"],
                              ),
                              title: Text(data['patietn_Full_Name'],style: TextStyle(fontWeight: FontWeight.w700,color: Colors.blue),),
                              subtitle:Text(data['Mobile'],style: TextStyle(fontWeight: FontWeight.w500),) ,
                            );
                          }));
              }
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => add_patient()));
        },
        label: Text('Add Patient Mannually'),
        icon: Icon(Icons.person_add),
        backgroundColor: Colors.blue,
        splashColor: Colors.orangeAccent,
      ),
    ));
  }
}
