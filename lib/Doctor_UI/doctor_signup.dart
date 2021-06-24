import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_patientmanagement_system/Alerts&Loaders/Dialog%20helper.dart';
import 'package:smart_patientmanagement_system/Alerts&Loaders/Doctor_signupLoader.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

import '../MultiSelectionExample.dart';
import '../Speciality.dart';


class docotr_signup extends StatefulWidget {

  @override
  _docotr_signupState createState() => _docotr_signupState();
}

class _docotr_signupState extends State<docotr_signup> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;

  Future selectTime(BuildContext context) async {
    final TimeOfDay _time =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (_time != null) {
      setState(() {
        Opening_Time = _time.format(context);

      });
    }
  }
  Future Closingtime(BuildContext context) async {
    final TimeOfDay _time =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (_time != null) {
      setState(() {
        closing_time = _time.format(context);

      });
    }
  }

  var Selected_Role;
  List<String> Role = <String>[
    'Doctor',
  ];
  String Gender_s='';
  var Selected_Gender;
  List<String> Gender = <String>[
    'Male','Female',
  ];
  List<String> catagory = <String>[
    'Heart Specialist','Diabetics specialist',
   'Nephrologist', 'Neurologist','ENT Specialist',
   'Dermatologist', 'Specialist in Gynecology & Obstetmcs', 'Specialist in Orthopaedics',
    'Specialist in General Medicine','Opthalmologist','Specialist in Forensic Medicine & Toxicology','Dentist','Pathologist','Psychiatrist',
  ];
  String catagorys='';
  var selectedcatagory;

  List<String> tmpArray=[];
  List<String> choicelist=[];




  // text field state
  String doctor_name = '';
  String  FullName = '';
  String Age="";

  String mobile = '';
  String about = '';
  String chambername = '';
  String chamberadress = '';
  String email = '';
  String password = '';
  String Role_of_Doctor = '';
  String Doctor_speciality = '';
  String Opening_Time = 'Enter Opening Time';
  String closing_time = 'Enter Closing Time';

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
                        color:Colors.blue,
                      ),
                      hintText: 'First Name',
                    ),
                    onChanged: (val) {
                      validator:
                          (val) => val.isEmpty ? 'Can not be emplty' : null;
                      setState(() => doctor_name = val);
                    },
                  ),  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color:Colors.blue,
                      ),
                      hintText: 'Full Name',
                    ),
                    onChanged: (val) {
                      validator:
                          (val) => val.isEmpty ? 'Can not be emplty' : null;
                      setState(() => FullName = val);
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
                            style: TextStyle(color: Color(0xff11b719)),
                          ),
                          value: value,
                        )).toList(),
                        onChanged: (
                            Selected_Role_type,
                            ) {
                          print('$Selected_Role_type');
                          setState(() {
                            Selected_Role = Selected_Role_type;
                            Role_of_Doctor = Selected_Role;
                          });
                        },
                        value: Selected_Role,
                        isExpanded: false,
                        hint: Text(
                          'Chose Your Role'.toUpperCase(),
                          style: TextStyle( color: Colors.blue,),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.add_business,  color: Colors.blue,),
                      hintText: 'Chamber Name',
                    ),
                    onChanged: (val) {
                      setState(() => chambername = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.add_comment,  color: Colors.blue,),
                      hintText: 'Chamber Address',
                    ),
                    onChanged: (val) {
                      setState(() => chamberadress = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.folder_special,
                        color: Colors.blue,
                      ),
                      hintText: 'Age (In Numbers)',
                    ),
                    onChanged: (val) {
                      validator:
                          (val) => val.isEmpty ? 'Can not be Empty' : null;
                      setState(() => Age = val);
                    },
                  ), SizedBox(
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
                            style: TextStyle(color: Colors.blue),
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
                          style: TextStyle( color: Colors.blue,),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.support_agent_outlined,
                        size: 25.0,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 50.0),
                      Expanded(
                        child: DropdownButton(
                          items: catagory.map((value) => DropdownMenuItem(
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.blue),
                            ),
                            value: value,
                          )).toList(),
                          onChanged: (
                              Selected_Role_type,
                              ) {
                            print('$Selected_Role_type');
                            setState(() {
                              selectedcatagory = Selected_Role_type;
                              catagorys = selectedcatagory;
                            });
                          },
                          value: selectedcatagory,
                          isExpanded: true,
                          hint: Text(
                            'Chose Your Speciality'.toUpperCase(),
                            style: TextStyle( color: Colors.blue,fontWeight: FontWeight.w500,),
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 20.0),





                  Container(
                    height: MediaQuery.of(context).size.height /9,
                    color: Colors.white70,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.access_time,color: Colors.white,),
                          Text(Opening_Time,style: TextStyle(color: Colors.white)),
                          TextButton.icon(
                              onPressed: () {
                                selectTime(context);
                              },
                              icon: Icon(Icons.access_time),
                              label: Text(
                                'Change',
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),

                  Container(
                    height: MediaQuery.of(context).size.height /9,
                    color: Colors.white70,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.access_time,color: Colors.white,),
                          Text(closing_time,style: TextStyle(color: Colors.white)),
                          TextButton.icon(
                              onPressed: () {
                                Closingtime(context);
                              },
                              icon: Icon(Icons.access_time),
                              label: Text(
                                'Change',
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                    ),
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
                              print('Check whether you Email is already in use');
                              return Dialog_Helper.alert(context);
                            });
                          } else {
                            List<String> splitlist=doctor_name.split(' ');
                            List<String> indexlist=[];
                            for(int i=0; i<splitlist.length;i++){
                              for(int j=0;j<=splitlist[i].length+i;j++){
                                indexlist.add(splitlist[i].substring(0,j).toLowerCase());

                              }
                            }
                            final uid = await _auth.getCurrenbtUid();
                            final QuerySnapshot qSnap = await firestore.collection('Doctors').get();
                            final int documents = qSnap.docs.length;
                            firestore
                                .collection('Doctors')
                                .doc(uid)
                                .set({
                              'Doctorname': doctor_name,
                              'Doctor_Full_Name': FullName,
                              'Gender': Gender_s,
                              'Age': Age,
                              'Doctor_unique_id': uid,
                              'Email': email,
                              'About': about,
                              'Mobile': mobile,
                              'ChamberName': chambername,
                              'ChamberAdress': chamberadress,
                              'Role': Role_of_Doctor,

                              'Chamber_Opening_Time': Opening_Time,
                              'Chamber_Closing_Time': closing_time,
                              'Created_at': FieldValue.serverTimestamp(),
                              'Doctor_id':documents+1,
                              'searchindex': indexlist,
                              'Speciality': catagorys,
                              

                            });


                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return loader();
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







}
