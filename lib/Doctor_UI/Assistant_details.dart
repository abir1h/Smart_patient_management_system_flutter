import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Assistants.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Dashboard.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';
class Assistant_details_doctor extends StatefulWidget {
  DocumentSnapshot info;
  Assistant_details_doctor({this.info});
  @override
  _Assistant_details_doctorState createState() => _Assistant_details_doctorState();
}

class _Assistant_details_doctorState extends State<Assistant_details_doctor> {
  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width*0.8;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
              onSelected: handleClick
              ,itemBuilder: (BuildContext context){
            return{'Delete Assistant'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          }  )
        ],
        title: Text('Assistant Details'.toUpperCase(),style: TextStyle(fontWeight: FontWeight.w900),),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Assistants()));
        }),
      ),
      body: SingleChildScrollView(

        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  AvatarLetter(
                    size: 70,
                    backgroundColor: Colors.blueAccent,
                    textColor: Colors.white,
                    fontSize: 30,
                    upperCase: true,
                    numberLetters: 1,
                    letterType: LetterType.Circular,
                    text: widget.info.data()["Assistant Name"],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 222,
                    height: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Text(
                            'Assistant Name'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Text(
                          widget.info.data()['Assistant Name'],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Has Experience of " +
                              widget.info['Experience'] +
                              ' years',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    Colors.black)),
                            onPressed: () {},
                            icon: Icon(Icons.call),
                            label: Text(
                              'Call Now',
                              style:
                              TextStyle(fontWeight: FontWeight.w500),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 26,
              ),
              Row(
                children: [
                  Icon(
                    Icons.work,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Bio",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                widget.info.data()['About'],
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_history,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Address",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width -
                                    268,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(left: 35.0),
                                  child: Text(
                                    widget.info['Assistant Address'],
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black,fontWeight: FontWeight.w900),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 40.0,
                  ),
                  Image.asset(
                    "images/map_final.png",
                    width: 180,
                    height: 100,
                  )
                ],
              ),
              Text(
                "Other Information",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 22,
              ),
              Column(children: [
                Row(
                  children: [
                    Text('Contact Number  :  ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                    Text(widget.info.data()['Mobile'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),)
                  ],
                ),
                Row(
                  children: [
                    Text('Email  :  ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                    Text(widget.info.data()['Email'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),)
                  ],
                ),
                Row(
                  children: [
                    Text('Gender  :  ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                    Text(widget.info.data()['Gender'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),)
                  ],
                ),
                Row(
                  children: [
                    Text('Age  :  ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                    Text(widget.info.data()['Age'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),)
                  ],
                ) ,Row(
                  children: [
                    Text('System Id  :  ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                    Text(widget.info.data()['Assistant_uid'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),)
                  ],
                ),Row(
                  children: [
                    Text('Doctor Id  :  ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                    Text(widget.info.data()['Doctor_uniqueid'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),)
                  ],
                )
              ],)

            ],
          ),
        ),
      ),
    ));
  }

  void handleClick(String value) {
    switch (value) {
      case 'Delete Assistant':
        getdocumetnid(widget.info);
        final snackBar = SnackBar(
          // Width of the SnackBar.
            duration: Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
            backgroundColor: Colors.black,
            content: Text('Assistant has been Deleted Successfully'),
            action: SnackBarAction(
              label: 'Dismiss',
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Dashboard()));
              },
            )
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Assistants()));

        break;

    }
  }
}
Future getdocumetnid(DocumentSnapshot info) async{

  final AuthService _auth=AuthService();
  final uid= await _auth.getCurrenbtUid();
  var doc_ref = await FirebaseFirestore.instance.collection("Doctor_Asistants").
  where('Doctor_uniqueid',isEqualTo: uid).get();
  doc_ref.docs.forEach((result) {

    FirebaseFirestore.instance.collection("Doctor_Asistants").doc(result.id).delete();

  }
  );

}