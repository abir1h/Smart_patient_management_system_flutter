import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_patientmanagement_system/Patient_Ui/findbycatagory.dart';
import 'package:smart_patientmanagement_system/Patient_Ui/prescriptions.dart';
import 'package:smart_patientmanagement_system/Starter/SignIn.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

import 'Appointments.dart';
import 'Diabetics specialist.dart';
import 'Doctor Details.dart';
import 'heatspecilsit.dart';
import 'neuphor.dart';
import 'neurologist.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController Search_Controller = TextEditingController();
  String Search_String;
  final _auth = AuthService();

  final firestore = FirebaseFirestore.instance;
Navigate(DocumentSnapshot info){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>prescriptions(info: info,)));
}
  @override
  Widget build(BuildContext context) {
    Route_To_Detail(DocumentSnapshot info) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => doctor_details(
                    info: info,
                  )));
    }

    final User user = auth.currentUser;
    final uid = user.uid;
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          "Find Your Consultation",
          style: TextStyle(
              color: Colors.black87.withOpacity(0.8),
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
      ),

      drawer: Drawer(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('Patients').doc(uid).snapshots(),
              builder: (context, snapshot) {
                if(snapshot.data!=null){
                  DocumentSnapshot data=snapshot.data;
                  return Column(
                  children: [
                    Image.asset('images/patient.jpg', height: size.height * .30),
                    ListTile(
                      hoverColor: Colors.blue,
                      leading: Icon(Icons.home, color: Colors.blue),
                      title: Text('Home'),
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Homepage()));
                      },
                    ),
                    ListTile(
                      hoverColor: Colors.blue,
                      leading: Icon(Icons.person, color: Colors.blue),
                      title: Text('Profile'),
                      onTap: () {},
                    ),
                    ListTile(
                      hoverColor: Colors.blue,
                      leading: Icon(Icons.calendar_today, color: Colors.blue),
                      title: Text('Prescriptions'),
                      onTap: () {
                        Navigate(data);
                        print(data['Mobile']);
                      },
                    ),
                    ListTile(
                      hoverColor: Colors.blue,
                      leading: Icon(Icons.dashboard, color: Colors.blue),
                      title: Text('Appointments'),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>appointments()));
                      },
                    ),
                    ListTile(
                      hoverColor: Colors.blue,
                      leading: Icon(Icons.info, color: Colors.blue),
                      title: Text('About Us'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.blue),
                      title: Text('Logout'),
                      onTap: () async {
                        await _auth.signout();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>SignIn()));
                      },
                    )
                  ],
                );}
                return CircularProgressIndicator();

              }
            ),
          ),
        ),
      )
          // Populate the Drawer in the next step.
          ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 1000,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Find  By Speciality',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: GridView(

                          scrollDirection: Axis.horizontal,
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 250,
                              childAspectRatio: 1 ,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 10

                          ),
                          children: [
                            GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>heart_specialist()));
                              },
                              child: Container(

                                color: Colors.white,
                                alignment: Alignment.topCenter,
                                child: Column(
                                  children: [
                                    Text('Heart Specialist', style: TextStyle(fontSize:20,fontWeight: FontWeight.w600,color: Colors.blue),),
                                    Expanded(child: Image.asset('images/img2.png'))
                                  ],
                                ),
                              ),
                            )
                            ,GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Diabetics_specialist()));
                              },
                              child: Container(

                                color: Colors.white,
                                alignment: Alignment.topCenter,
                                child: Column(
                                  children: [
                                    Text('Diabetics specialist', style: TextStyle(fontSize:20,fontWeight: FontWeight.w600,color: Colors.blue),),
                                    Expanded(child: Image.asset('images/diabete.png'))
                                  ],
                                ),
                              ),
                            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Nephrologist()));
              },
              child: Container(

                color: Colors.white,
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Text('Nephrologist', style: TextStyle(fontSize:20,fontWeight: FontWeight.w600,color: Colors.blue),),
                    Expanded(child: Image.asset('images/Nephrologist.png'))
                  ],
                ),
              ),
            ),
             GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Neurologist()));
              },
              child: Container(

                color: Colors.white,
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Text('Neurologist', style: TextStyle(fontSize:20,fontWeight: FontWeight.w600,color: Colors.blue),),
                    Expanded(child: Image.asset('images/Neurologist.png'))
                  ],
                ),
              ),
            ), GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>find_by_catagory()));
                              },
                              child: Container(

                                color: Colors.white,
                                alignment: Alignment.bottomCenter,
                                child: Center(child: Row(
                                  children: [
                                    Text('View All', style: TextStyle(fontSize:20,fontWeight: FontWeight.w600,color: Colors.blue),),
                                    Icon(Icons.arrow_forward,color: Colors.blue,)
                                  ],
                                )),
                              ),
                            )

                          ],
                        )),
                    Row(
                      children: [
                        Text('Featured Doctors',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            )),
                      ],
                    )
                    ,Column(
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
                    hintText: 'Search Doctors Name',
                    hintStyle: TextStyle(
                        color: Colors.blue, fontSize: 20)),
              ),
            ),
          ],
        ),

                    Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                      stream:
                          (Search_String == null || Search_String.trim() == '')
                              ? firestore.collection('Doctors').snapshots()
                              : firestore
                                  .collection('Doctors')
                                  .where('searchindex',
                                      arrayContains: Search_String)
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
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      DocumentSnapshot data =
                                          snapshot.data.docs[index];
                                      return ListTile(
                                          trailing: IconButton(
                                              icon: Icon(
                                                Icons.info_outlined,
                                                color: Colors.blue,
                                              ),
                                              onPressed: () =>
                                                  Route_To_Detail(data)),
                                          leading: AvatarLetter(
                                            size: 50,
                                            backgroundColor: Colors.indigo,
                                            textColor: Colors.black,
                                            fontSize: 20,
                                            upperCase: true,
                                            numberLetters: 1,
                                            letterType: LetterType.Circular,
                                            text: data["Doctor_Full_Name"],
                                          ),
                                          title: Text(
                                            data['Doctor_Full_Name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          subtitle: Text(
                                            data['Speciality'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.blue),
                                          ));
                                    }));
                        }
                      },
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
