import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_patientmanagement_system/Alerts&Loaders/Doctor_signupLoader.dart';
import 'package:smart_patientmanagement_system/Alerts&Loaders/update_profile%20Laoder.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Dashboard.dart';
import 'package:smart_patientmanagement_system/Doctor_tabbar_pages/Basic_Info.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';
class edit_profile extends StatefulWidget {
  DocumentSnapshot info;
  edit_profile({this.info});
  @override
  _edit_profileState createState() => _edit_profileState();
}

class _edit_profileState extends State<edit_profile> {

  final _formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;
final AuthService _auth=AuthService();


  // text field state

  String Patient_Name = 'dkhjsgf';
  String mobile = '';
  String Age = '';
  String Address = '';
  String email = '';
  String password = '';
  String Gender_s='';
  String selected_gender = '';
  var Selected_Gender;
  List<String> Gender = <String>[
    'Male','Female',
  ];




  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.blue ,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Dashboard()));
        }),
        title: Text('Edit profile'.toUpperCase()),


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
                        Icons.person_pin_rounded,
                        color: Colors.blue,
                      ),
                      hintText: 'Patient Name',
                    ),
                    onChanged: (val) {
                      setState(() => Patient_Name = val);
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
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.location_on,
                        color:  Colors.blue,
                      ),
                      hintText: 'Address',
                    ),
                    onChanged: (val) {
                      setState(() => Address = val);
                    },
                  ),

                  SizedBox(height: 20.0),


                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.folder_special,
                        color:  Colors.blue,
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
                            style: TextStyle(color:  Colors.blue,fontWeight: FontWeight.w700),
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
                          style: TextStyle( color:  Colors.blue,fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(onPressed: () async{
                    List<String> splitlist=Patient_Name.split(' ');
                    List<String> indexlist=[];
                    for(int i=0; i<splitlist.length;i++){
                      for(int j=0;j<=splitlist[i].length+i;j++){
                        indexlist.add(splitlist[i].substring(0,j).toLowerCase());

                      }
                    }
                    final AuthService _auth=AuthService();
                    final uid= await _auth.getCurrenbtUid();
                    var doc_ref = await FirebaseFirestore.instance.collection('Under_doctor_patients').doc(uid).collection('patients').where('Phone',isEqualTo: widget.info.data()['Phone']).get();
                    doc_ref.docs.forEach((result) {

                      FirebaseFirestore.instance.collection("Doctors").doc(uid).collection("Doctor_patients").doc(result.id).update({
                        'Patient_Name': Patient_Name,
                        'Gender': Gender_s,
                        'Phone': mobile,
                        'Address': Address,
                        'Age': Age,
                        'searchindex': indexlist,


                      });

                    });
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Update_laoder()));


                  }, child: Text("Update Profile"),
                    style: ElevatedButton.styleFrom(
                        primary:  Colors.blue,
                        elevation: 18.0,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),)

                ])),
          ),
        )
    ));
  }
}
