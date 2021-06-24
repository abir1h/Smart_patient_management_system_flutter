import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/Asstant_hoem_page.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/patient_detail.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

import 'Assistant_patient_details.dart';
class Assistant_patients extends StatefulWidget {
  DocumentSnapshot info;
  Assistant_patients({this.info});

  @override
  _Assistant_patientsState createState() => _Assistant_patientsState();
}

class _Assistant_patientsState extends State<Assistant_patients> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController Search_Controller = TextEditingController();
  String Search_String;
  final _auth = AuthService();

  final firestore = FirebaseFirestore.instance;



  @override
  Widget build(BuildContext context) {



    final User user = auth.currentUser;
    final uid = user.uid;


    Route_To_Detail(DocumentSnapshot info){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Assistant_patietnDetails(info: info,)));
    }

    return SafeArea(
        child:
              Scaffold(
                appBar: AppBar(
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
                                        color: Colors.blue,
                                        size: 30,
                                      ),
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.clear_outlined,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () => Search_Controller.clear()),
                                      hintText: 'Search Patient Name',
                                      hintStyle: TextStyle(
                                          color: Colors.blue, fontSize: 20)),
                                ),
                              ),
                              Text('Patients',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28,)),
                            ],

                          ),

                          Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: (Search_String == null || Search_String.trim() == '')
                                    ? firestore
                                    .collection('Under_doctor_patients').doc(widget.info.data()['Doctor_uniqueid']).collection('patients')
                                    .snapshots()
                                    : firestore
                                    .collection('Under_doctor_patients').doc(widget.info.data()['Doctor_uniqueid']).collection('patients')
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
                                            color: Colors.blue,
                                          ),
                                        ),
                                      );
                                    case (ConnectionState.none):
                                      return Center(
                                          child: Text(
                                            "Opps! No data found.",
                                            style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ));
                                    default:
                                      return Padding(
                                          padding: const EdgeInsets.all(2.0),

                                          child: new ListView.builder(
                                              itemCount: snapshot.data.docs.length,
                                              itemBuilder: (BuildContext context,int index){
                                                DocumentSnapshot data = snapshot.data.docs[index];
                                                return ListTile(
                                                  onTap: ()=>Route_To_Detail(data),
                                                  leading: AvatarLetter(
                                                    size: 50,
                                                    backgroundColor: Colors.indigo,
                                                    textColor: Colors.black,
                                                    fontSize: 20,
                                                    upperCase: true,
                                                    numberLetters: 1,
                                                    letterType: LetterType.Circular,
                                                    text: data["Patient_Name"],
                                                  ),
                                                  title: Text(data['Patient_Name'],style: TextStyle(fontWeight: FontWeight.w700),),
                                                );
                                              })
                                      );
                                  }
                                },
                              )),

                        ],
                      )

                ),
              );



  }
}


