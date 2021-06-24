import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Assistants.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Auto_add_assistant.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

import 'Dashboard.dart';
class add_assistant extends StatefulWidget {
  @override
  _add_assistantState createState() => _add_assistantState();
}

class _add_assistantState extends State<add_assistant> {
  Route_To_assistant_detail(DocumentSnapshot info){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>auto_add_assistant(info: info,)));
  }
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController Search_Controller = TextEditingController();
  String Search_String;
  final AuthService _auth = AuthService();

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;
    final uid = user.uid;



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
                      MaterialPageRoute(builder: (context) => Assistants()));
                }),
            title: Text(
              'Assistants'.toUpperCase(),
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
                          hoverColor: Colors.black,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 30,
                          ),
                          suffixIcon: IconButton(
                              icon: Icon(
                                Icons.clear_outlined,
                                color: Colors.black,
                              ),
                              onPressed: () => Search_Controller.clear()),
                          hintText: 'Search Assistant Name',
                          hintStyle:
                          TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                  ),
                  Text("Assistant's Throughout the App",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      )),
                ],
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: (Search_String == null || Search_String.trim() == '')
                        ? firestore.collection('Assistants').snapshots()
                        : firestore
                        .collection('Assistants')
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
                                  itemBuilder: (BuildContext context, int index) {
                                    DocumentSnapshot data = snapshot.data.docs[index];
                                    return ListTile(


                                        trailing: IconButton(icon: Icon(Icons.info,color: Colors.blue,), onPressed: (){
                                          onTap: Route_To_assistant_detail(data);
                                        }),

                                      leading: AvatarLetter(
                                        size: 50,
                                        backgroundColor: Colors.orangeAccent,
                                        textColor: Colors.white,
                                        fontSize: 20,
                                        upperCase: true,
                                        numberLetters: 1,
                                        letterType: LetterType.Circular,
                                        text: data["Assistant Name"],
                                      ),
                                      title: Text(data['Assistant Name'],style: TextStyle(fontWeight: FontWeight.w500,color: Colors.blue)),
                                      subtitle: Text("Experience :"+data['Experience']+"Years",style: TextStyle(fontWeight: FontWeight.w500),),

                                    );
                                  }));
                      }
                    },
                  )),
            ],
          ),

        ));
  }
}
