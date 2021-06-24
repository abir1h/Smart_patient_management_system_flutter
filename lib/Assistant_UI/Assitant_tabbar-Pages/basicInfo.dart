import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Assitant_Basicinfo extends StatefulWidget {
  DocumentSnapshot info;
  Assitant_Basicinfo({this.info});
  @override
  _Assitant_BasicinfoState createState() => _Assitant_BasicinfoState();
}

class _Assitant_BasicinfoState extends State<Assitant_Basicinfo> {
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      AvatarLetter(

                        text: widget.info.data()['Patient_Name'],
                        textColor: Colors.white,
                        backgroundColor: Colors.indigo,
                        fontSize: 40,
                        size: 60,
                        upperCase: true,
                        numberLetters: 1,
                        letterType: LetterType.Circular,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Patient_Name: '.toUpperCase(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey),),
                      ),
                      Text( widget.info.data()['patietn_Full_Name'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black,),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:30.0,top: 10.0),
                  child: Row(
                    children: [
                      Icon(Icons.person_pin, color: Colors.orangeAccent,),
                      SizedBox(width: 15,),
                      Text("Gender :",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey)),
                      SizedBox(width: 10,),
                      Text(widget.info.data()['Gender'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black,))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,top: 10.0),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, color: Colors.orangeAccent,),
                      SizedBox(width: 15,),
                      Text("Age :",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey)),
                      SizedBox(width: 10,),
                      Text(widget.info.data()['Age'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black,))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,top: 10.0),
                  child: Row(
                    children: [
                      Icon(Icons.phone_android, color: Colors.orangeAccent,),
                      SizedBox(width: 15,),
                      Text("Phone :",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey)),
                      SizedBox(width: 10,),
                      Text(widget.info.data()['Phone'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black,))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,top: 10.0),
                  child: Row(
                    children: [
                      Icon(Icons.map_outlined, color: Colors.orangeAccent,),
                      SizedBox(width: 15,),
                      Text("Address :",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey)),
                      SizedBox(width: 10,),
                      Text(widget.info.data()['Address'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black,))
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text("System".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 25),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,top: 10.0),
                  child: Column(
                    children: [
                      Icon(Icons.person_pin_rounded, color: Colors.orangeAccent,),
                      SizedBox(width: 15,),
                      Text("Created At :",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey)),
                      SizedBox(width: 10,),
                      Text(widget.info.data()["Created_at"].toDate().toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black,))
                    ],
                  ),
                ),


              ],
            ),
          )
        ],
      ),
    );
  }
}
