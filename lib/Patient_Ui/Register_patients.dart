import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_patientmanagement_system/Alerts&Loaders/Doctor_signupLoader.dart';
import 'package:smart_patientmanagement_system/Alerts&Loaders/Loader_Patient.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

class patient_sign_up extends StatefulWidget {
  @override
  _patient_sign_upState createState() => _patient_sign_upState();
}

class _patient_sign_upState extends State<patient_sign_up> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;


  var Selected_Role;
  List<String> Role = <String>[
    'Patient',
  ];

  // text field state
  String Gender_s='';
  String Patient_Name = '';
  String Full_name = '';
  String mobile = '';
  String Age = '';
  String Address = '';
  String email = '';
  String password = '';
  String Role_of_Patient= '';

  String selected_gender = '';
  var Selected_Gender;
  List<String> Gender = <String>[
    'Male','Female',
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Center(
              child: Text(
                'SIGIN UP',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  SizedBox(height: 20.0),
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
                      setState(() => Patient_Name = val);
                    },
                  ),
                  SizedBox(height: 20.0), TextFormField(
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
                      setState(() => Full_name = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.mobile_friendly,
                        color: Colors.blue,
                      ),
                      hintText: 'Mobile Phone',
                    ),
                    onChanged: (val) {
                      setState(() => mobile = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Colors.blue,
                      ),
                      hintText: 'Email',
                    ),
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: Colors.blue,
                      ),
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.perm_identity,
                        size: 25.0,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 50.0),
                      DropdownButton(
                        items: Role.map((value) => DropdownMenuItem(
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w900),
                          ),
                          value: value,
                        )).toList(),
                        onChanged: (
                            Selected_Role_type,
                            ) {
                          print('$Selected_Role_type');
                          setState(() {
                            Selected_Role = Selected_Role_type;
                            Role_of_Patient = Selected_Role;
                          });
                        },
                        value: Selected_Role,
                        isExpanded: false,
                        hint: Text(
                          'Chose Your Role'.toUpperCase(),
                          style: TextStyle( color:Colors.blue,fontWeight: FontWeight.w900),
                        ),
                      )
                    ],
                  ),


                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.folder_special,
                        color:Colors.blue,
                      ),
                      hintText: 'Address',
                    ),
                    onChanged: (val) {
                      validator:
                          (val) => val.isEmpty ? 'Can not be Empty' : null;
                      setState(() => Address = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Select Gender',
                    style: TextStyle(fontWeight: FontWeight.w900,color:Colors.blue),
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
                            style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w900),
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
                          style: TextStyle( color: Colors.blue,fontWeight: FontWeight.w900),
                        ),
                      )
                    ],
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.folder_special,
                        color: Colors.blue,
                      ),
                      hintText: 'Age',
                    ),
                    onChanged: (val) {
                      validator:
                          (val) => val.isEmpty ? 'Can not be Empty' : null;
                      setState(() => Age = val);
                    },
                  ),
                  SizedBox(height: 20.0),


                  ElevatedButton(

                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),

                      onPressed: () async {

                        if (_formKey.currentState.validate()) {
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              print('error');
                            });
                          } else {
                            List<String> splitlist=Patient_Name.split(' ');
                            List<String> indexlist=[];
                            for(int i=0; i<splitlist.length;i++){
                              for(int j=0;j<=splitlist[i].length+i;j++){
                                indexlist.add(splitlist[i].substring(0,j).toLowerCase());

                              }
                            }
                            final uid = await _auth.getCurrenbtUid();
                            final QuerySnapshot qSnap = await firestore.collection('Patients').get();
                            final int documents = qSnap.docs.length;
                            firestore
                                .collection('Patients')
                                .doc(uid)
                                .set({
                              'Patient_Name': Patient_Name,
                              'patietn_Full_Name': Full_name,
                              'Gender': Gender_s,

                              'patient_uid': uid,
                              'Email': email,
                              'Mobile': mobile,
                              'Address': Address,
                              'Age': Age,
                              'Role': Role_of_Patient,

                              'Created_at': FieldValue.serverTimestamp(),
                              'Patient_id':documents+1,
                              'searchindex': indexlist,

                            });


                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return Loader_patient();
                            }));
                          }
                        }
                      }),
                ])),
          ),
        ),
      ),
    );
  }

  Future<bool> usernameCheck(String username) async {
    final result = await firestore
        .collection('Usernames')
        .where('username', isEqualTo: username)
        .get();
    return result.docs.isEmpty;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('User Name Taken!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please try with a different User Name.'),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
