import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Visit.dart';
import 'package:url_launcher/url_launcher.dart';
class actions_doctor extends StatefulWidget {
  DocumentSnapshot info;
  actions_doctor({this.info});

  @override
  _actions_doctorState createState() => _actions_doctorState();
}

class _actions_doctorState extends State<actions_doctor> {

  @override
  Widget build(BuildContext context) {
    String phone=widget.info.data()['phone'];
    String Date=widget.info.data()['Date'];
    String Doctor=widget.info.data()['Doctor Name'];
    String problem=widget.info.data()['description'];
    String Patient_name=widget.info.data()['name'];
    String specialist_id=widget.info.data()['Specialist-id'];
    String pid=widget.info.data()['Patient_uid'];
    String Serial=widget.info.data()['Serial'].toString();
    String Appointment_Status='Serving';
    String Appointment_Status_after_serve='Served';

    String message = "This is a test message!";
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Take Action",
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
                  MaterialPageRoute(builder: (_) => visits()));
            }),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                elevation: 2,
                primary: Colors.blue,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
              ),
              onPressed: () {
                launch('sms:+$phone?body=Dear $Patient_name,\nThis is a gental reminder that you have an appointment with us on $Date\nWhat: $problem\nWhen:$Date\nPhone:$phone\n\nPlease take tour to your dashboard to check the seral numbers.\n\nWe Look forward to seeing you');

              },
              icon: Icon(Icons.notification_important_outlined,color: Colors.white,size: 24,),
              label: Text('Send Reminder',style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 2,
              primary: Colors.blue,
              onPrimary: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
              ),
            ),
            onPressed: () async{

              FirebaseFirestore.instance.collection('Serving').doc(specialist_id).collection(Date).add({
                'Serial': Serial,
                'Date': Date,
                'Patient Name': Patient_name,
                'Phone': phone,
                'Doctor ID': specialist_id,
                'Appointment Status': Appointment_Status,
              });
            },
            icon: Icon(Icons.loop_sharp,color: Colors.white,size: 24,),
            label: Text('Serve',style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            )),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 2,
              primary: Colors.green,
              onPrimary: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
              ),
            ),
            onPressed: () async{
              var doc_ref = await
              FirebaseFirestore.instance.collection('Serving').doc(specialist_id).collection(Date)
                  .where('Appointment Status', isEqualTo:Appointment_Status )
                  .get();
              doc_ref.docs.forEach((result)async{
                FirebaseFirestore.instance.collection('Serving').doc(specialist_id).collection(Date).doc(result.id).update({
                  'Appointment Status': Appointment_Status_after_serve,
                });
              });
              String status_served='3';
              var doc_ref2 = await FirebaseFirestore.instance
                  .collection('appointments')
                  .doc(specialist_id)
                  .collection('Pending')
                  .where('Patient_uid', isEqualTo: pid)
                  .get();
              doc_ref2.docs.forEach((result)async{
                FirebaseFirestore.instance.collection('appointments')
                    .doc(specialist_id)
                    .collection('Pending')
                    .doc(result.id)
                    .update({
                  'Status':status_served,
                });
              });
              var doc_ref3 = await FirebaseFirestore.instance
                  .collection('Appointment_History')
                  .doc(pid)
                  .collection('appointments')
                  .where('Specialist-id', isEqualTo: specialist_id).where('Date',isEqualTo: Date)
                  .get();
              doc_ref3.docs.forEach((result)async{
                FirebaseFirestore.instance
                    .collection('Appointment_History')
                    .doc(pid)
                    .collection('appointments').doc(result.id).update({

                  'Status' :status_served,
                });
              });

            }

            ,
            icon: Icon(Icons.check_circle_rounded,color: Colors.white,size: 24,),
            label: Text('Finish Appointment',style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            )),
          ),
        ],
      ),
    ));
  }
}
