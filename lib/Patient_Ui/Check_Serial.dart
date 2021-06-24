import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_patientmanagement_system/Patient_Ui/Approved%20Appointments.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Check_serial extends StatefulWidget {
  DocumentSnapshot info;
  Check_serial({this.info});
  @override
  _Check_serialState createState() => _Check_serialState();
}

class _Check_serialState extends State<Check_serial> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  String formattedDate;
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthService _auth = AuthService();

  String status_Finish = 'Finished';

  String Status_queued = 'Queued';
  change_status() {
    setState(() {
      Status_queued = 'Finished';
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;
    final uid = user.uid;
    var heigth = MediaQuery.of(context).size.height;
    String doctor_id = widget.info.data()['Specialist-id'];
    String Date = widget.info.data()['Date'];
    String pid = widget.info.data()['Patient_uid'];

    String Status = widget.info.data()['Status'];
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Appointment Details",
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            )),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => approved_appointments()));
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Text('Appointment Date - ',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      )),
                  Text(widget.info.data()['Date'],
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Text('Doctor Name - ',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      )),
                  Text(widget.info.data()['Doctor Name'],
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Text('Reason for Appointment - ',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      )),
                  Text(widget.info.data()['description'],
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ],
              ),
            ),SizedBox(height: heigth/10,),
            Column(
              children: [
                Container(
                  height: heigth / 5,
                  width: width / 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text("Total  Patients",
                              style: GoogleFonts.lato(
                                fontSize:22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              )),
                          SizedBox(height: heigth/20,),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('appointments')
                                  .doc(doctor_id)
                                  .collection('Pending')
                                  .where('Status', isEqualTo: Status)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                var data = snapshot.data.docs.length;
                                if (snapshot.hasData) {
                                  return Text(data.toString(),style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w700,
                                  ));

                                } return CircularProgressIndicator();


                              })
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(17)),
                  ),
                ),
              ],
            ),SizedBox(height: heigth/16,),

            Padding(
              padding: const EdgeInsets.only(left:18.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: heigth / 5,
                        width: width / 2.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text("Serving Serial",
                                    style: GoogleFonts.lato(
                                      fontSize:22,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    )),
                                SizedBox(height: heigth/20,),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Serving')
                                        .doc(doctor_id)
                                        .collection(Date)
                                        .where('Appointment Status', isEqualTo: 'Serving')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.docs.length,
                                          itemBuilder: (_,index){
                                            DocumentSnapshot data = snapshot.data.docs[index];
                                            return ListTile(
                                              title: Center(
                                                child: Text('#'+data['Serial'].toString(),style: GoogleFonts.lato(
                                                  color: Colors.white,
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                              ),
                                            );
                                          });

                                      } return CircularProgressIndicator();


                                    })
                              ],
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(17)),
                        ),
                      ),
                    ],
                  ),SizedBox(width: width/10,),
                  Column(
                    children: [
                      Container(
                        height: heigth / 5,
                        width: width / 2.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text("Your Serial",
                                    style: GoogleFonts.lato(
                                      fontSize:22,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    )),
                                SizedBox(height: heigth/25,),
                                StreamBuilder<QuerySnapshot>(
                                     stream: FirebaseFirestore.instance
                                    .collection('appointments')
                                    .doc(doctor_id)
                                    .collection('Pending')
                                    .where('Patient_uid', isEqualTo: pid)
                                    .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        var data = snapshot.data.docs.length;
                                        return ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: data,
                                            itemBuilder: (_,index){
                                              DocumentSnapshot info=snapshot.data.docs[index];
                                              return Center(
                                                child: Text('#'+info.data()['Serial'].toString(),style: GoogleFonts.lato(
                                                  color: Colors.white,
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                              );
                                            });

                                      } return CircularProgressIndicator();


                                    })
                              ],
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(17)),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),SizedBox(height: heigth/16,),
            Text("Today Appointments List",style: GoogleFonts.lato(

              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            )),

            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('appointments')
                    .doc(doctor_id)
                    .collection('Pending')
                    .where('Status', isEqualTo: Status)
                    .snapshots(),
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context,index){
                          DocumentSnapshot data =
                          snapshot.data.docs[index];
                          return ListTile(
                            isThreeLine: true,
                            leading:AvatarLetter(
                              size: 60,
                              backgroundColor: Colors.blueAccent,
                              textColor: Colors.white,
                              fontSize: 30,
                              upperCase: true,
                              numberLetters: 1,
                              letterType: LetterType.Circular,
                              text: data["name"],
                            ),
                            title: Text(data['name'],style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            )),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Serial: ' +data['Serial'].toString(),style: GoogleFonts.lato(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            )) ,Text('Reason: ' +data['description'],style: GoogleFonts.lato(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            )),Text('Appointment Date: ' +data['Date'],style: GoogleFonts.lato(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            )),
                            ],
                          ),
                          );
                        });

                  } return CircularProgressIndicator();


                })
          ],
        ),
      ),
    ));
  }

  countDocuments(String doctor_id) async {
    String Status = '1';
    final QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection('appointments')
        .doc(doctor_id)
        .collection('Pending')
        .where('Status', isEqualTo: Status)
        .get();
   final int documents=qSnap.docs.length-1;

    print(documents);
    return documents;
  }
}
