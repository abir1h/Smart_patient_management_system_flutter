import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_patientmanagement_system/Alerts&Loaders/aisstant_signup.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';
class assistant_register extends StatefulWidget {
  @override
  _assistant_registerState createState() => _assistant_registerState();
}

class _assistant_registerState extends State<assistant_register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  String About='';
  var Selected_Role;
  List<String> Role = <String>[
    'Assistant',
  ];
  String Gender_s=''; String selected_gender = '';
  var Selected_Gender;
  List<String> Gender = <String>[
    'Male','Female',
  ];
  // text field state
  String final_username='';
  String fullname='';

  String assistant_name = '';
  String experience = '';
  String mobile = '';
  String Age = '';


  String adress = '';
  String email = '';
  String password = '';

  String Role_of_assistant = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Center(
              child: Text(
                'Assistant Signup'.toUpperCase(),
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
                      setState(() => assistant_name = val);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.drive_file_rename_outline,
                        color: Colors.blue,
                      ),
                      hintText: 'Full Name',
                    ),
                    onChanged: (val) {
                      validator:
                          (val) => val.isEmpty ? 'Can not be emplty' : null;
                      setState(() =>fullname = val);
                    },
                  ),
                  SizedBox(height: 20.0),TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.mobile_screen_share,
                        color: Colors.blue,
                      ),
                      hintText: 'Phone',
                    ),
                    onChanged: (val) {
                      validator:
                          (val) => val.isEmpty ? 'Can not be emplty' : null;
                      setState(() => mobile = val);
                    },
                  ),
                  SizedBox(height: 20.0),
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
                            style: TextStyle(color:Colors.blue,fontWeight: FontWeight.w900),
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
                          style: TextStyle( color:Colors.blue,),
                        ),
                      )
                    ],
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
                        color: Color(0xffFBB97C),
                      ),
                      SizedBox(width: 50.0),
                      DropdownButton(
                        items: Role.map((value) => DropdownMenuItem(
                          child: Text(
                            value,
                            style: TextStyle(color:Colors.blue,fontWeight: FontWeight.w900),
                          ),
                          value: value,
                        )).toList(),
                        onChanged: (
                            Selected_Role_type,
                            ) {
                          print('$Selected_Role_type');
                          setState(() {
                            Selected_Role = Selected_Role_type;
                            Role_of_assistant = Selected_Role;
                          });
                        },
                        value: Selected_Role,
                        isExpanded: false,
                        hint: Text(
                          'Choose  Role'.toUpperCase(),
                          style: TextStyle( color:Colors.blue,fontWeight: FontWeight.w900,),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.add_business,  color: Colors.blue,),
                      hintText: 'Address',
                    ),
                    onChanged: (val) {
                      setState(() => adress = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today,  color: Colors.blue,),
                      hintText: 'Age',
                    ),
                    onChanged: (val) {
                      setState(() => Age = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.work_rounded,
                        color: Color(0xffFBB97C),
                      ),
                      hintText: 'Experience (In Years)',
                    ),
                    onChanged: (val) {
                      validator:
                          (val) => val.isEmpty ? 'Can not be Empty' : null;
                      setState(() => experience = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                      child: Text('Register'.toUpperCase(),style: TextStyle(fontWeight: FontWeight.w800),),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
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
                            List<String> splitlist=assistant_name.split(' ');
                            List<String> indexlist=[];
                            for(int i=0; i<splitlist.length;i++){
                              for(int j=0;j<=splitlist[i].length+i;j++){
                                indexlist.add(splitlist[i].substring(0,j).toLowerCase());

                              }
                            }
                            final uid=await _auth.getCurrenbtUid();
                            firestore.collection('Assistants').doc(uid).set({
                              'Assistant Name': assistant_name,
                              'Assistant_Full_Name': fullname,

                              'Gender': Gender_s,
                              'Email': email,
                              'Mobile': mobile,
                              'Age': Age,
                              'About': About,

                              'Assistant Address': adress,
                              'Role': Role_of_assistant,
                              'Experience': experience,
                              'searchindex': indexlist,
                              'Assistant_uid': uid,
                              'Created_at': FieldValue.serverTimestamp(),



                            });

                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return assistant_signup_loader();
                            }));
                          }
                        }
                      }),
                ])),
          ),
        ),
      ),
    );;
  }
}
