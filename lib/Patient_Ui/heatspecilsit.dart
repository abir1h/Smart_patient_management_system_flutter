import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Doctor Details.dart';
import 'Homepage.dart';
class heart_specialist extends StatefulWidget {
  @override
  _heart_specialistState createState() => _heart_specialistState();
}

class _heart_specialistState extends State<heart_specialist> {
  Navigatedata(DocumentSnapshot info){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>doctor_details(info: info,)));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar:  AppBar(
        title: Text('Heart Specialists list'),
        leading: IconButton(icon: Icon (Icons.arrow_back), onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Homepage()));
        }),),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:FirebaseFirestore.instance.collection('Doctors').where('Speciality',isEqualTo: 'Heart Specialist').snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.data==null){
                    print('no result');
                    return Container(
                      height: 100,
                      width: 200,
                      color: Colors.blue,
                      child: Text('No doctors Available'),
                    );
                  }

                  if (snapshot.hasData) {
    return Padding(
    padding: const EdgeInsets.all(2.0),
    child: new ListView.builder(
    itemCount: snapshot.data.docs.length,
    itemBuilder: (BuildContext context, int index) {
    DocumentSnapshot data = snapshot.data.docs[index];
    return ListTile(
    trailing: IconButton(icon: Icon(Icons.info,color:Colors.blue), onPressed: (){
      Navigatedata(data);
    }),
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
      subtitle: Text(data['Speciality'],style: TextStyle(fontWeight: FontWeight.w700,color: Colors.blue),),
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
