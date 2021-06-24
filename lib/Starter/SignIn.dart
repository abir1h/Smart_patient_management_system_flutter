import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_patientmanagement_system/Alerts&Loaders/Dialoghelper.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/Asstant_hoem_page.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Dashboard.dart';
import 'package:smart_patientmanagement_system/Patient_Ui/Homepage.dart';
import 'package:smart_patientmanagement_system/Starter/whoryou.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

import 'forget_password.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  final formkey = GlobalKey<FormState>();


  String email = '';
  String password = '';
  String error = '';
  String Role_of_user = '';
  var Selected_Role;
  List<String> Role = <String>['Doctor', 'Patient','Assistant'];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size;
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 26),
                child: Form(
                    key: formkey,
                    child: Column(children: [
                      Image.asset('images/anim.jpg',height: size.height*.30,),

                      TextFormField(
                        decoration: InputDecoration(hintText: "Email Adress",icon: Icon(Icons.email_rounded,color: Colors.blue,)),
                        validator: (val) => val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(hintText: "Password",icon: Icon(Icons.email_rounded,color: Colors.blue,)),
                        obscureText: true,
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
                            if (Selected_Role == 'Doctor') {
                              Role_of_user = 'Doctor';
                            } else if (Selected_Role == 'Patient') {
                              Role_of_user = 'Patient';
                            }else if (Selected_Role == 'Assistant') {
                              Role_of_user = 'Assistant';
                            }
                          });
                        },
                        value: Selected_Role,
                        isExpanded: false,
                        hint: Text(
                          'Chose Your Role'.toUpperCase(),
                          style: TextStyle(color:Colors.blue,fontWeight: FontWeight.w900),
                        ),
                      ),
                      Padding(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>forget_password()));
                          },
                          child: Text("Forget Password?",style: TextStyle(color: Colors.red),),
                        ),
                        padding: EdgeInsets.only(right: 230),
                      ),
                      SizedBox(height: 20.0),

                      ElevatedButton.icon(

                          onPressed: () async {
                            final SharedPreferences sharedpreferences= await SharedPreferences.getInstance();
                            sharedpreferences.setString('Role', Role_of_user);
                            if (formkey.currentState.validate()) {
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  return DialogHelper.alert(context);
                                });
                              } else {
                                if (Role_of_user == 'Doctor') {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Dashboard()));
                                } else if (Role_of_user == 'Patient') {

                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Homepage()));
                                }else if (Role_of_user == 'Assistant') {

                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>assistant_homepage()));
                                }
                              }
                            }
                          },
                          icon: Icon(
                            Icons.lock_open,
                            color: Colors.white,size: 20,
                          ),
                          label: Text(
                            'Sign In',
                            style: TextStyle(fontSize: 20,
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                         ),
                      SizedBox(height: 12.0),
                      TextButton.icon(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return whoareyou();
                                }));
                          },
                          icon: Icon(Icons.arrow_forward,color:Colors.blue,),
                          label: Text('Not Registred? Get Started!',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w900),))
                    ]))),
          ),
        ));

  }
}