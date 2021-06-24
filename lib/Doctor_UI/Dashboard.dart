import 'package:flutter/material.dart';
import 'package:smart_patientmanagement_system/Alerts&Loaders/catagorycard.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Add_patietn.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Main_add_Patient.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/patients.dart';

import 'Assistants.dart';
import 'More.dart';
import 'Visit.dart';
import 'doctor_profile.dart';
class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.more,),
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (_){return More();
        }));},
      ),

      body: Stack(
        children: <Widget>[
          Container(

            // Here the height of the container is 45% of our total height
            height: size.height * .45,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(

                  bottomRight: Radius.circular(90.0)),
              color: Colors.blue,
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("images/undraw_pilates_gpdb.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Hello,Doctor!!",
                    style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30)
                  ),
                  SizedBox(height: 20,),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CategoryCard(
                          title: "Doctor Profile".toUpperCase(),

                          imgsrc: "images/doctor.jpg",
                          press: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>doctor_profile()));
                          },
                        ),
                        CategoryCard(
                          title: "Patients".toUpperCase(),
                          imgsrc: "images/patient_icon.png",
                          press: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> patients() ));
                          },
                        ),
                        CategoryCard(
                          title: "Visits".toUpperCase(),
                          imgsrc: "images/information.png",
                          press: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>visits()));
                          },
                        ),
                        CategoryCard(
                          title: "Add Patient".toUpperCase(),
                          imgsrc: "images/add.png",
                          press: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>main_add_patient()));
                          },
                        ),CategoryCard(
                          title: "Assitant".toUpperCase(),
                          imgsrc: "images/ass.png",
                          press: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Assistants()));
                          },
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}