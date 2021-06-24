
import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_patientmanagement_system/Alerts&Loaders/catagorycard.dart';
import 'package:smart_patientmanagement_system/Alerts&Loaders/doctor_info_laoder.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/Assistant_auto_add_patient.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/Assistant_patients.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/Assistant_profile.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/Doctor_info.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/assistantadd-mannual_addpatient.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/manage_%20patients/Manage_Patients.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/see%20patients.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Add_patietn.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/More.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/doctor_profile.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/patients.dart';
import 'package:smart_patientmanagement_system/Starter/SignIn.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';
import 'package:smart_patientmanagement_system/rough.dart';

import 'Assistant_add_patient_auto.dart';
class assistant_homepage extends StatefulWidget {
  @override
  _assistant_homepageState createState() => _assistant_homepageState();
}

class _assistant_homepageState extends State<assistant_homepage> {
  NavigateData(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Assistant_profile()));
  }NavigateDrinfoData(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Assistant_profile()));
  } NavigateData2(DocumentSnapshot info){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Assistant_patients(info: info,)));
  } NavigateData2Assistant_autoadd(DocumentSnapshot info){
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Assistant_add_patient(assistantinfo: info,)));
  } NavigateData2Doctor_info(DocumentSnapshot info){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>DI_laoder()));
  }
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;
    final uid = user.uid;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: Colors.black87),
          ),


          drawer: Drawer(
              elevation: 4.0,
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    CircleAvatar(
                      maxRadius: 50,
                      child: Icon(Icons.person,size: 50,) ,
                      backgroundColor: Colors.blue,

                    ),
                    ListTile(
                      hoverColor: Colors.greenAccent,
                      leading: Icon(Icons.home,color: Colors.blue,size:40),
                      title: Text('Home',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){}
                        ));
                      },
                    ),
                    ListTile(
                      hoverColor: Colors.greenAccent,
                      leading: Icon(Icons.person,color: Colors.blue,size:40),
                      title: Text('Profile',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17)),
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){}
                        ));
                      },
                    ),
                   ListTile(
                      hoverColor: Colors.greenAccent,
                      leading: Icon(Icons.info,color: Colors.blue,size:40),
                      title: Text('About Us',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17)),
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {}
                        ));
                      },
                    ),ListTile(

                      leading: Icon(Icons.logout,color: Colors.blue,size:40),
                      title: Text('Logout',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17)),
                      onTap: ()async{
                        await _auth.signout();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>SignIn()));

                      },
                    )
                  ],
                ),
              ),
            ),
          ) // Populate the Drawer in the next step.
          ),
          body: StreamBuilder<DocumentSnapshot>(
              stream:FirebaseFirestore.instance.collection("Assistants").doc(uid).snapshots()
        
        ,builder: (_,snapshot){
                if(snapshot.data!= null){
                  DocumentSnapshot data=snapshot.data;

                  return Scaffold(
                    body: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [

                            Center(child: Text('Hello,'+ snapshot.data['Assistant Name'],style: TextStyle(fontWeight: FontWeight.w900,fontSize: 40),)),
                          GestureDetector(
                            onTap: ()=>NavigateData(),
                            child: Padding(
                              padding: const EdgeInsets.only(top:35.0,left: 15.0,right: 15.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height/10,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:28.0),
                                      child: Text('Assistant Profile',style:TextStyle(fontWeight: FontWeight.w700,fontSize:27,color: Colors.white),),
                                    ),Padding(
                                      padding: const EdgeInsets.only(left:58.0),
                                      child: Icon(Icons.person_pin_rounded,color: Colors.white,size: 30),
                                    )

                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(Radius.circular(17)),
                                ),


                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          GestureDetector(
                            onTap: (){
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>seepatients()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height/10,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:28.0),
                                      child: Text('Patients',style:TextStyle(fontWeight: FontWeight.w700,fontSize:27,color: Colors.white),),
                                    ),Padding(
                                      padding: const EdgeInsets.only(left:150.0),
                                      child: Icon(Icons.supervised_user_circle,color: Colors.white,size: 30),
                                    )

                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(Radius.circular(17)),
                                ),


                              ),
                            ),
                          ),  SizedBox(height: 10,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Addpatient_dialog()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height/10,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:28.0),
                                      child: Text('Add Patients',style:TextStyle(fontWeight: FontWeight.w700,fontSize:27,color: Colors.white),),
                                    ),Padding(
                                      padding: const EdgeInsets.only(left:100.0),
                                      child: Icon(Icons.person_add_alt_1_rounded,color: Colors.white,size: 30),
                                    )

                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(Radius.circular(17)),
                                ),


                              ),
                            ),
                          ), SizedBox(height: 10,),
                          GestureDetector(
                            onTap: (){
                              NavigateData2Doctor_info(data);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height/10,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:28.0),
                                      child: Text('Doctor Information',style:TextStyle(fontWeight: FontWeight.w700,fontSize:27,color: Colors.white),),
                                    ),Padding(
                                      padding: const EdgeInsets.only(left:30.0),
                                      child: Icon(Icons.ac_unit_outlined,color: Colors.white,size: 30),
                                    )

                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(Radius.circular(17)),
                                ),


                              ),
                            ),
                          ), GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Manage_patients()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height/10,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left:28.0),
                                      child: Text('Manage Patients',style:TextStyle(fontWeight: FontWeight.w700,fontSize:27,color: Colors.white),),
                                    ),Padding(
                                      padding: const EdgeInsets.only(left:30.0),
                                      child: Icon(Icons.dashboard,color: Colors.white,size: 30),
                                    )

                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(Radius.circular(17)),
                                ),


                              ),
                            ),
                          ),

                          ],
                        ),
                      ),
                    ),
                  );
                }
                
          return
            Center(
                    child: SpinKitDoubleBounce(
                    color: Colors.white,
                    size: 60.0,


                ),);}),));
  }
}
