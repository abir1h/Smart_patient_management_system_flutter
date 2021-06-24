import 'package:flutter/material.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Assistants.dart';
import 'package:smart_patientmanagement_system/Starter/SignIn.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

import 'Dashboard.dart';
import 'doctor_profile.dart';
class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(leading: InkWell(child: Icon(Icons.arrow_back,),onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_){return Dashboard();
            }));
          },),title: Center(child: Text('More')),backgroundColor: Colors.blue,),
          body: Column(
            children: [
              ListTile(
                hoverColor: Colors.blue,
                leading: Icon(Icons.home,color: Colors.blue),
                title: Text('Home'),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Dashboard()
                  ));
                },
              ),
              ListTile(
                hoverColor: Colors.blue,
                leading: Icon(Icons.person,color: Colors.blue),
                title: Text('Patients'),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> doctor_profile()
                  ));
                },
              ),
              ListTile(
                hoverColor: Colors.blue,
                leading: Icon(Icons.calendar_today,color: Colors.blue),
                title: Text('Visits'),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> doctor_profile()
                  ));
                },
              ),
              ListTile(
                hoverColor: Colors.blue,
                leading: Icon(Icons.person,color: Colors.blue),
                title: Text('Doctor'),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> doctor_profile()
                  ));
                },
              ),ListTile(
                hoverColor: Colors.blue,
                leading: Icon(Icons.info,color: Colors.blue),
                title: Text('About Us'),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> doctor_profile()
                  ));
                },
              ),ListTile(

                leading: Icon(Icons.logout,color: Colors.blue),
                title: Text('Logout'),
                onTap: ()async{
                  await _auth.signout();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignIn()
                  ));

                },
              )
            ],
          ),

        ));
  }
}