import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_patientmanagement_system/Alerts&Loaders/Assistant_add_patient_laoder.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/Assistant_add_patient_auto.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/Asstant_hoem_page.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';
class Assistant_auto_add_patient extends StatefulWidget {
  DocumentSnapshot info,Assistant_info;
  Assistant_auto_add_patient({this.info,this.Assistant_info});
  @override
  _Assistant_auto_add_patientState createState() => _Assistant_auto_add_patientState();
}

class _Assistant_auto_add_patientState extends State<Assistant_auto_add_patient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Assistant_add_patient()));
            }),
        backgroundColor: Colors.blue,
        title: Center(child: Text('Add Patient')),
      ),
      body:Center(
        child: Stack(
          children: [
            Container(

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  SizedBox(height: 100,),
                  Text(
                    'Are You Sure?',
                    style: TextStyle(
                        fontSize: 26,fontWeight: FontWeight.w700

                    ),

                  ),
                  SizedBox(height: 16,),
                  Text('You want to add this patient',style: TextStyle(fontSize: 16),),
                  SizedBox(height: 24,),
                  Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(onPressed: (){
                          addpatient(widget.info,widget.Assistant_info);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>assistant_add_loader_patient()));

                        }, child: Text('YES'.toUpperCase(),style: TextStyle(fontWeight:FontWeight.w700,fontSize: 25),)),

                        SizedBox(width: 200,),
                        TextButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>assistant_homepage()));
                        }, child: Text('No'.toUpperCase(),style: TextStyle(fontWeight:FontWeight.w700,fontSize: 25),)),
                      ],
                    ),
                  )

                ],
              ),
              padding: EdgeInsets.only(
                  top: 100,
                  left: 16,right: 16,bottom: 16
              ),
              margin: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(17),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,

                    )
                  ]
              ),
            ),
            Positioned(

                top: 0,
                left: 16,
                right: 16,
                child: Center(
                    child: ClipOval(
                      child: Container(
                        height: 150,
                        width: 150,
                        color: Colors.grey.shade200,
                        child: Image.asset(
                          'images/question.png',
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                )

            )
          ],
        ),
      ),
    );
  }
}

Future addpatient(DocumentSnapshot info,DocumentSnapshot assitant_info) async {
  final AuthService _auth = AuthService();
  List<String> splitlist = info.data()['Patient_Name'].split(' ');
  List<String> indexlist = [];
  for (int i = 0; i < splitlist.length; i++) {
    for (int j = 0; j <= splitlist[i].length + i; j++) {
      indexlist.add(splitlist[i].substring(0, j).toLowerCase());
    }
  }
  final uid = await _auth.getCurrenbtUid();
  FirebaseFirestore.instance
      .collection('Under_doctor_patients').doc(assitant_info.data()['Doctor_uniqueid']).collection('patients')
      .add({
    'Patient_Name': info.data()['Patient_Name'],
    'Gender': info.data()['Gender'],
    'Age': info.data()['Age'],
    'Phone': info.data()['Mobile'],
    'Address': info.data()['Address'],
    'Patient_id': info.data()['Patient_id'],
    'Doctor_uniqueid': uid,

    'Created_at': FieldValue.serverTimestamp(),
    'searchindex': indexlist,
  });
}
