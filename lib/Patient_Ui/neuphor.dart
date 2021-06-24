import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Homepage.dart';

class Nephrologist extends StatefulWidget {
  @override
  _NephrologistState createState() => _NephrologistState();
}

class _NephrologistState extends State<Nephrologist> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        appBar:  AppBar(
          title: Text('Nephrologists list'),
          leading: IconButton(icon: Icon (Icons.arrow_back), onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Homepage()));
          }),),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream:FirebaseFirestore.instance.collection('Doctors').where('Speciality',isEqualTo: 'Nephrologist').snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.data==null){
                        Text('No results');

                      }

                      if (snapshot.hasData) {
                        return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: new ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  DocumentSnapshot data = snapshot.data.docs[index];
                                  return ListTile(
                                    trailing: IconButton(icon: Icon(Icons.person_add,color:Colors.blue), onPressed: (){}),
                                    leading: AvatarLetter(
                                      size: 50,
                                      backgroundColor: Colors.blueAccent,
                                      textColor: Colors.black,
                                      fontSize: 20,
                                      upperCase: true,
                                      numberLetters: 1,
                                      letterType: LetterType.Circular,
                                      text: data["Doctor_Full_Name"],
                                    ),
                                    title: Text(data['Doctor_Full_Name'],style: TextStyle(fontWeight: FontWeight.w700),),
                                  );
                                }));
                      }
                      return Text("No doctors Available yet");

                    }

                )),
          ],
        )
    ));
  }
}
