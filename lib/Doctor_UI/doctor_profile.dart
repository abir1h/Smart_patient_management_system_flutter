import 'dart:math';

import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Dashboard.dart';
import 'package:smart_patientmanagement_system/Starter/SignIn.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

class doctor_profile extends StatefulWidget {
  @override
  _doctor_profileState createState() => _doctor_profileState();
}

class _doctor_profileState extends State<doctor_profile> {

  TextEditingController profilename_controller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profilename_controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;
    final uid = user.uid;
    double c_width = MediaQuery.of(context).size.width*0.8;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.login_outlined,color: Colors.black,size: 35,), onPressed: ()async{
            final AuthService _auth=AuthService();
            await _auth.signout();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignIn()
            ));
          })
        ],
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Dashboard()));
            }),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Profile'.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black),
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Doctors")
              .doc(uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              DocumentSnapshot data = snapshot.data;
              return SingleChildScrollView(

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Center(
                            child: AvatarLetter(
                              size: 80,
                              backgroundColor: Colors.blueAccent,
                              textColor: Colors.white,
                              fontSize: 50,
                              upperCase: true,
                              numberLetters: 1,
                              letterType: LetterType.Circular,
                              text: data["Doctorname"],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 130, top: 20),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                data["Doctor_Full_Name"],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 30),
                              ),
                              SizedBox(
                                width: 0,
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(data['Doctor Speciality'],style: TextStyle(fontSize: 20),),
                        Padding(
                          padding: const EdgeInsets.only(left: 130, top: 20),
                          child: Row(
                            children: [
                              Text(
                                'Doctor ID :',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 25),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                data["Doctor_id"].toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 30),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, top: 20),
                          child: Row(
                            children: [
                              Text(
                                'Email :',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                data["Email"].toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 22),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text('Bio',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 22),),
                            SizedBox(width: 10,),
                            IconButton(icon: Icon(Icons.edit,color: Colors.orange), onPressed: (){
                              ShowAboutDialog(context);
                            })
                          ],
                        ),
                      ),
                    ),Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(data['About'], style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text('Chamber Address',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 22),),
                            SizedBox(width: 10,),
                            IconButton(icon: Icon(Icons.edit,color: Colors.orange), onPressed: (){
                              ShowAddressDialog(context);
                            })
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text( data['ChamberAdress'], style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),),
                      ),

                    ),Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text('Other Information',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 22),),
                            SizedBox(width: 10,),
                            IconButton(icon: Icon(Icons.edit,color: Colors.orange), onPressed: (){
                              ShowotherDialog(context);
                            })
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text( "Phone:", style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16),),
                                SizedBox(width: 15,),
                                Text( data['Mobile'], style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                              ],
                            ),Row(
                              children: [
                                Text( "Chamber Name: ", style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16),),
                                SizedBox(width: 15,),
                                Text( data['ChamberName'], style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                              ],
                            ),Row(
                              children: [
                                Text( "Gender", style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16),),
                                SizedBox(width: 15,),
                                Text( data['Gender'], style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                              ],
                            ),

                          ],
                        ),
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text('System',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 22),),
                            SizedBox(width: 10,),

                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        width: c_width,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text( "Doctor Unique ID", style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16),),
                                SizedBox(width: 15,),
                                Flexible(child: Text( data['Doctor_unique_id'], style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),)),
                              ],
                            ),
                          ],
                        ),
                      ),

                    )


                  ],
                ),
              );
            }
            return  Center(
              child: SpinKitCubeGrid(
                color: Colors.orange,
                size: 60.0,

              ),
            );
          }),
    ));
  }



 ShowAboutDialog(BuildContext context) {
   TextEditingController controller=TextEditingController();
   // set up the AlertDialog
   AlertDialog alert = AlertDialog(
     title: Text('Add Bio'),
     content: TextField(
       controller: controller,
     ),
     actions: [
       TextButton(
           onPressed: () async {
             String Name=controller.text;

             final AuthService _auth = AuthService();
             final uid = await _auth.getCurrenbtUid();
             FirebaseFirestore.instance.collection("Doctors").doc(uid).update({
               'About': Name,

             });
             Navigator.pop(context);
           },
           child: Text('Update'.toUpperCase()))
     ],
   );
   // show the dialog
   showDialog(
     context: context,
     builder: (BuildContext context) {
       return alert;
     },
   );
}


 ShowAddressDialog(BuildContext context) {
   TextEditingController controller=TextEditingController();
   // set up the AlertDialog
   AlertDialog alert = AlertDialog(
     title: Text('Change Chamber Address'),
     content: TextField(
       controller: controller,
     ),
     actions: [
       TextButton(
           onPressed: () async {
             String Name=controller.text;

             final AuthService _auth = AuthService();
             final uid = await _auth.getCurrenbtUid();
             FirebaseFirestore.instance.collection("Doctors").doc(uid).update({
               'ChamberAdress': Name,

             });
             Navigator.pop(context);
           },
           child: Text('Update'.toUpperCase()))
     ],
   );
   // show the dialog
   showDialog(
     context: context,
     builder: (BuildContext context) {
       return alert;
     },
   );
}
 ShowotherDialog(BuildContext context) {
   TextEditingController controller=TextEditingController();
   TextEditingController Chamber_Controller=TextEditingController();

   // set up the AlertDialog
   AlertDialog alert = AlertDialog(

     title: Text('Edit Other Details'),
     content: Column(
       children: [
         TextField(
           decoration: InputDecoration(
             hintText: 'Enter Number',
           ),
           controller: controller,
         ), TextField(
           decoration: InputDecoration(
             hintText: 'Enter Chamber Name',
           ),
           controller: Chamber_Controller,
         ),

       ],
     ),
     actions: [
       TextButton(
           onPressed: () async {
             String Phone=controller.text;
             String ChamberName=Chamber_Controller.text;


             final AuthService _auth = AuthService();
             final uid = await _auth.getCurrenbtUid();
             FirebaseFirestore.instance.collection("Doctors").doc(uid).update({
               'Mobile': Phone,
               'ChamberName': ChamberName,


             });
             Navigator.pop(context);
           },
           child: Text('Update'.toUpperCase()))
     ],
   );
   // show the dialog
   showDialog(
     context: context,
     builder: (BuildContext context) {
       return alert;
     },
   );
}



showAlertDialog(BuildContext context, DocumentSnapshot info,
   ) {
  // set up the button
TextEditingController controller=TextEditingController();
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Change Doctor Name'),
    content: TextField(
      controller: controller,
    ),
    actions: [
      TextButton(
          onPressed: () async {
            String Name=controller.text;
            List<String> splitlist = Name.split(' ');
            List<String> indexlist = [];
            for (int i = 0; i < splitlist.length; i++) {
              for (int j = 0; j <= splitlist[i].length + i; j++) {
                indexlist.add(splitlist[i].substring(0, j).toLowerCase());
              }
            }
            final AuthService _auth = AuthService();
            final uid = await _auth.getCurrenbtUid();
            FirebaseFirestore.instance.collection("Doctors").doc(uid).update({
              'Doctorname': Name,
              'searchindex': indexlist,
            });
            Navigator.pop(context);
          },
          child: Text('Update'.toUpperCase()))
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}}
