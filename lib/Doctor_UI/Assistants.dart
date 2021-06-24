import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Assistant_details.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

import 'More.dart';
import 'Register_Assistants.dart';
import 'add_assistant.dart';

class Assistants extends StatefulWidget {


  @override
  _AssistantsState createState() => _AssistantsState();
}

class _AssistantsState extends State<Assistants> {
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthService _auth=AuthService();

  navigate_details(DocumentSnapshot info){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Assistant_details_doctor(info: info)));
  }
  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;
    final uid = user.uid;

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.add,
                      size: 40,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => add_assistant()));
                  },
                )
              ],
              title: Center(
                  child: Text(
                'ASISTANTS',
                style: TextStyle(color: Colors.white),
              )),
              backgroundColor:Colors.blue,
              leading: InkWell(
                child: Icon(
                  Icons.arrow_back,
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => More()));
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('Assinged Asistants',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'AveriaLibre',
                            fontSize: 20)),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Doctor_Asistants").where('Doctor_uniqueid',isEqualTo: uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:  ListView.builder(
                              shrinkWrap: true,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  DocumentSnapshot data = snapshot.data.docs[index];
                                  return ListTile(
                                    onTap:()=> navigate_details(data),
                                    horizontalTitleGap: 20.0,
                                      minVerticalPadding: 30.0,
                                      leading:AvatarLetter(
                                        size: 50,
                                        backgroundColor: Colors.blue,
                                        textColor: Colors.black,
                                        fontSize: 20,
                                        upperCase: true,
                                        numberLetters: 1,
                                        letterType: LetterType.Circular,
                                        text: data["Assistant Name"],
                                        fontWeight: FontWeight.w900,
                                      ),
                                    title: Text(data["Assistant Name"],style: TextStyle(fontWeight: FontWeight.w900),),
                                  );
                                },

                            ),
                          );
                        }if(snapshot.connectionState==ConnectionState.none){
                          return Center(child: Text('No Data'));
                        }
                        return CircularProgressIndicator();
                      })
                ],
              ),
            )));
  }
}

