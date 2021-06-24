import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';
class visits_tab extends StatefulWidget {
  DocumentSnapshot info;
  visits_tab({this.info});
  @override
  _visits_tabState createState() => _visits_tabState();
}

class _visits_tabState extends State<visits_tab> {
  final AuthService _auth = AuthService();
  FirebaseAuth auth = FirebaseAuth.instance;

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;
    final uid = user.uid;
     String patientid=widget.info.data()['Patient_id'].toString();
     String patientuid=widget.info.data()['patient_uid'].toString();
     String Status='3';
    return SingleChildScrollView(
      child:  Column(children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Appointment_History')
                .doc(patientuid)
                .collection('appointments')
                .where('Status', isEqualTo: Status)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('No Results');
              }
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data =
                    snapshot.data.docs[index];
                    String patient_uid =
                    data['Patient_uid'].toString();
                    String Date = data['Date'].toString();
                    return ListTile(
                      leading: AvatarLetter(

                        text:  data['description'],
                        textColor: Colors.white,
                        backgroundColor: Colors.blue,
                        fontSize: 26,fontWeight: FontWeight.w700,
                        size: 60,
                        upperCase: true,
                        numberLetters: 2,
                        letterType: LetterType.Circular,
                      ),
                      minVerticalPadding: 10,
                      isThreeLine: true,
                      title: Text("Reason - "+
                        data['description'],
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      subtitle: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Visited to  Dr.' +
                                  data['Doctor Name'],
                              style: GoogleFonts.lato(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                          Text('On : ' + data['Date'],
                              style: GoogleFonts.lato(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),


                        ],
                      ),
                    );
                  });
            })],)
    );
  }
}
