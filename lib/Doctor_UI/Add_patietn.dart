import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:smart_patientmanagement_system/Alerts&Loaders/Add_aptient_Loaders.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Dashboard.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Main_add_Patient.dart';

import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

class add_patient extends StatefulWidget {
  @override
  _add_patientState createState() => _add_patientState();
}

class _add_patientState extends State<add_patient> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;
  String First_name = '';
  String Fullname = '';
  String selected_gender = '';
  String Age = '';
  String Phone = '';
  String Email = '';
  String Gender_s='';
  String Address = '';
  String Reffered_Doctor_id = '';
  var Selected_Gender;
  List<String> Gender = <String>[
    'Male','Female',
  ];

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.blue,
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>main_add_patient()));
          },
        ),
        title: Text(
          'New Patient',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        actions: [
          InkWell(
              child: Padding(
                padding: const EdgeInsets.only(top: 14.0,right: 14.0),
                child: Text(
                  'Save'.toUpperCase(),
                  style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  List<String> splitlist=First_name.split(' ');
                  List<String> indexlist=[];
                  for(int i=0; i<splitlist.length;i++){
                    for(int j=0;j<=splitlist[i].length+i;j++){
                      indexlist.add(splitlist[i].substring(0,j).toLowerCase());

                    }
                  }
                  final uid=await _auth.getCurrenbtUid();
                  FirebaseFirestore.instance..collection('Under_doctor_patients').doc(uid).collection('patients')
                      .add({
                    'Patient_Name': First_name,
                    'patietn_Full_Name': Fullname,
                    'Gender': Gender_s,
                    'Age': Age,
                    'Phone': Phone,
                    'Address': Address,
                    'Doctor_id': Reffered_Doctor_id,
                    'Doctor_uniqueid': uid,
                    'Addres': Address,
                    'Created_at': FieldValue.serverTimestamp(),
                    'searchindex': indexlist,

                  });
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Loader_ADD_patient()));
                } else {}
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      hintText: 'First Name',
                    ),
                    onChanged: (val) {
                      validator:
                      (val) => val.isEmpty ? 'Can not be emplty' : null;
                      setState(() => First_name = val);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),        TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      hintText: 'Full Name',
                    ),
                    onChanged: (val) {
                      validator:
                      (val) => val.isEmpty ? 'Can not be emplty' : null;
                      setState(() => Fullname = val);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Select Gender',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),

        Row(
          children: <Widget>[
            Icon(
              Icons.perm_identity,
              size: 25.0,
              color: Colors.blue,
            ),
            SizedBox(width: 50.0),
            DropdownButton(
              items: Gender.map((value) => DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(color:Colors.blue,fontWeight: FontWeight.w700),
                ),
                value: value,
              )).toList(),
              onChanged: (
                  Selected_Role_type,
                  ) {
                print('$Selected_Role_type');
                setState(() {
                  Selected_Gender = Selected_Role_type;
                  Gender_s = Selected_Gender;
                });
              },
              value: Selected_Gender,
              isExpanded: false,
              hint: Text(
                'Chose Your Gender'.toUpperCase(),
                style: TextStyle( color: Colors.blue,fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Colors.blue,
                      ),
                      hintText: 'Age (In Numbers)',
                    ),
                    onChanged: (val) {
                      validator:
                      (val) => val.isEmpty ? 'Can not be emplty' : null;
                      setState(() => Age = val);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.phone_android,
                        color: Colors.blue,
                      ),
                      hintText: 'Phone',
                    ),
                    onChanged: (val) {
                      validator:
                      (val) => val.isEmpty ? 'Can not be emplty' : null;
                      setState(() => Phone = val);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.mail,
                        color: Colors.blue,
                      ),
                      hintText: 'Email',
                    ),
                    onChanged: (val) {
                      validator:
                      (val) => val.isEmpty ? 'Can not be emplty' : null;
                      setState(() => Email = val);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.map_outlined,
                        color: Colors.blue,
                      ),
                      hintText: 'Address',
                    ),
                    onChanged: (val) {
                      validator:
                      (val) => val.isEmpty ? 'Can not be emplty' : null;
                      setState(() => Address = val);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.room_preferences,
                        color: Colors.blue,
                      ),
                      hintText: 'Referred Doctor ID',
                    ),
                    onChanged: (val) {
                      validator:
                      (val) => val.isEmpty ? 'Can not be emplty' : null;
                      setState(() => Reffered_Doctor_id = val);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              )),
        ),
      ),
    ));
  }
}
