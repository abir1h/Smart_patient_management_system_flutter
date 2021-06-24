import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/Asstant_hoem_page.dart';
import 'package:smart_patientmanagement_system/Starter/SignIn.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';
class Doctor_info extends StatefulWidget {
  DocumentSnapshot info;
  Doctor_info({this.info});
  @override
  _Doctor_infoState createState() => _Doctor_infoState();
}

class _Doctor_infoState extends State<Doctor_info> {

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width*0.8;
    return Scaffold(
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
                  context, MaterialPageRoute(builder: (_) => assistant_homepage()));
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
              .doc(widget.info.data()['Doctor_uniqueid'])
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              DocumentSnapshot data = snapshot.data;
              return SingleChildScrollView(

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.start,
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
                                data["Doctorname"],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 30),
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
    );
  }
}
