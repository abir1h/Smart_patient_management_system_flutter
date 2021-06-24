import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

import 'Manage_Patients.dart';

class Appointment_requsts extends StatefulWidget {
  DocumentSnapshot info;
  Appointment_requsts({this.info});
  @override
  _Appointment_requstsState createState() => _Appointment_requstsState();
}

class _Appointment_requstsState extends State<Appointment_requsts> {
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;
    final uid = user.uid;
    var heigth = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Doctors')
                .doc(widget.info.data()['Doctor_uniqueid'])
                .snapshots(),
            builder: (context, snapshot) {
              DocumentSnapshot data1 = snapshot.data;
              String doctor_id = data1['Doctor_id'].toString();
             if(snapshot.data!=null){

               return Scaffold(
                 appBar: AppBar(
                   elevation: 0,
                   backgroundColor: Colors.white,
                   title: Text("Apponitment Requests",
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
                         Navigator.pushReplacement(
                             context,
                             MaterialPageRoute(
                                 builder: (_) => Manage_patients()));
                       }),
                 ),
                 body: SingleChildScrollView(
                   child: Column(
                     children: [
                       StreamBuilder<QuerySnapshot>(
                           stream: FirebaseFirestore.instance
                               .collection('appointments')
                               .doc(doctor_id)
                               .collection('Pending')
                               .where('Status', isEqualTo: '0')
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
                                     minVerticalPadding: 10,
                                     isThreeLine: true,
                                     title: Text(
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
                                             'Appointment Request To  Dr.' +
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
                                         Text('Status : PENDING',
                                             style: GoogleFonts.lato(
                                               color: Colors.red,
                                               letterSpacing: 5,
                                               fontSize: 16,
                                               fontWeight: FontWeight.bold,
                                             )),
                                         Row(
                                           children: [
                                             SizedBox(
                                               width: width / 3,
                                             ),
                                             IconButton(
                                                 icon: Icon(
                                                   Icons.clear,
                                                   color: Colors.red,
                                                 ),
                                                 onPressed: () {
                                                   _showDialog(
                                                       context,
                                                       doctor_id,
                                                       patient_uid,
                                                       Date);
                                                 }),
                                             IconButton(
                                                 icon: Icon(
                                                   Icons.check,
                                                   color: Colors.green,
                                                 ),
                                                 onPressed: () {
                                                   _showDialog(
                                                       context,
                                                       doctor_id,
                                                       patient_uid,
                                                       Date);
                                                 })
                                           ],
                                         ),
                                       ],
                                     ),
                                   );
                                 });
                           })
                     ],
                   ),
                 ),
               );
             }return LinearProgressIndicator();
            }));
  }
}

void _showDialog(
    BuildContext context, String doctorid, String patient_uid, String date) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Are you Sure!!!"),
        content: Center(
          child: new Text(
            "You want to add this appointment",
            style: GoogleFonts.lato(
              color: Colors.green,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: <Widget>[
          // ignore: deprecated_member_use
          new FlatButton(
            child: new Text(
              "Yes",
              style: GoogleFonts.lato(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () async {
              String status = '1';
              var doc_ref = await FirebaseFirestore.instance
                  .collection('appointments')
                  .doc(doctorid)
                  .collection('Pending')
                  .where('Patient_uid', isEqualTo: patient_uid)
                  .get();
              doc_ref.docs.forEach((result) async{
                final QuerySnapshot qSnap = await FirebaseFirestore.instance
                    .collection('appointments')
                    .doc(doctorid)
                    .collection('Pending').where('Status',isEqualTo: status)
                    .get();
                final int documents = qSnap.docs.length;
                FirebaseFirestore.instance
                    .collection("appointments")
                    .doc(doctorid)
                    .collection("Pending")
                    .doc(result.id)
                    .update({
                       'Status': status,
                       'Serial': documents + 1,

                });
              });


              var doc_ref2 = await FirebaseFirestore.instance
                  .collection('Appointment_History')
                  .doc(patient_uid)
                  .collection('appointments')
                  .where('Specialist-id', isEqualTo: doctorid)
                  .get();
              doc_ref2.docs.forEach((result) {
                FirebaseFirestore.instance
                    .collection('Appointment_History')
                    .doc(patient_uid)
                    .collection('appointments')
                    .doc(result.id)
                    .update({'Status': status});
              });
              Navigator.of(context).pop();
            },
            // ignore: deprecated_member_use
          ),
          // ignore: deprecated_member_use
          new FlatButton(
            child: new Text(
              "No",
              style: GoogleFonts.lato(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () async{
              String status_c='Cancelled';
              var doc_ref = await FirebaseFirestore.instance
                  .collection('appointments')
                  .doc(doctorid)
                  .collection('Pending')
                  .where('Patient_uid', isEqualTo: patient_uid)
                  .get();
              doc_ref.docs.forEach((result) async{

                FirebaseFirestore.instance
                    .collection("appointments")
                    .doc(doctorid)
                    .collection("Pending")
                    .doc(result.id)
                    .update({
                  'Status': status_c,


                });
              });
              var doc_ref2 = await FirebaseFirestore.instance
                  .collection('Appointment_History')
                  .doc(patient_uid)
                  .collection('appointments')
                  .where('Specialist-id', isEqualTo: doctorid)
                  .get();
              doc_ref2.docs.forEach((result) {
                FirebaseFirestore.instance
                    .collection('Appointment_History')
                    .doc(patient_uid)
                    .collection('appointments')
                    .doc(result.id)
                    .update({'Status': status_c});
              });

              final snackBar = SnackBar(
                // Width of the SnackBar.
                  duration: Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 10,
                  backgroundColor: Colors.black,
                  content: Text('Request Cancelled'),
                  action: SnackBarAction(
                    label: 'Dismiss',
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){}));
                    },
                  )
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
Future getdocumetnid(DocumentSnapshot info) async{

  final AuthService _auth=AuthService();
  final uid= await _auth.getCurrenbtUid();
  var doc_ref = await FirebaseFirestore.instance.collection("Under_doctor_patients").doc(uid).collection('patients').
  where('Phone',isEqualTo: info.data()['Phone']).get();
  doc_ref.docs.forEach((result) {

    FirebaseFirestore.instance..collection("Under_doctor_patients").doc(uid).collection('patients').doc(result.id).delete();

  }
  );

}