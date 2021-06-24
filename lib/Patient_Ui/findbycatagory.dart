import 'package:flutter/material.dart';
import 'package:smart_patientmanagement_system/Patient_Ui/Homepage.dart';

import 'Dermatologist.dart';
import 'Diabetics specialist.dart';
import 'ENT Specialist.dart';
import 'Opthalmologist.dart';
import 'Pathologist.dart';
import 'Psychiatrist.dart';
import 'Specialist in Forensic Medicine & Toxicology.dart';
import 'Specialist in General Medicine.dart';
import 'Specialist in Gynecology & Obstetmcs.dart';
import 'Specialist in Orthopaedics.dart';
import 'heatspecilsit.dart';
import 'neuphor.dart';
import 'neurologist.dart';
class find_by_catagory extends StatefulWidget {
  @override
  _find_by_catagoryState createState() => _find_by_catagoryState();
}

class _find_by_catagoryState extends State<find_by_catagory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Find By Catagory'.toUpperCase()),
        leading: IconButton(icon: Icon (Icons.arrow_back), onPressed: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Homepage()));
      }),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>heart_specialist()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top:35.0,left: 15.0,right: 15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text('Heart Specialist',style:TextStyle(fontWeight: FontWeight.w700,fontSize:27,color: Colors.white),)),

                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(17)),
                  ),


                ),
              ),
            ),GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Diabetics_specialist()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top:35.0,left: 15.0,right: 15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text('Diabetics Specialist',style:TextStyle(fontWeight: FontWeight.w700,fontSize:27,color: Colors.white),)),

                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(17)),
                  ),


                ),
              ),
            ),GestureDetector(
        onTap: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Nephrologist()));
        },
        child: Padding(
          padding: const EdgeInsets.only(top:35.0,left: 15.0,right: 15.0),
          child: Container(
            height: MediaQuery.of(context).size.height/10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('Nephrologist',style:TextStyle(fontWeight: FontWeight.w700,fontSize:27,color: Colors.white),)),

              ],
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(17)),
            ),


          ),
        ),
    ),GestureDetector(
        onTap: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Neurologist()));
        },
        child: Padding(
          padding: const EdgeInsets.only(top:35.0,left: 15.0,right: 15.0),
          child: Container(
            height: MediaQuery.of(context).size.height/10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('Neurologist',style:TextStyle(fontWeight: FontWeight.w700,fontSize:27,color: Colors.white),)),

              ],
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(17)),
            ),


          ),
        ),
    ),GestureDetector(
        onTap: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>ENT_Specialist()));
        },
        child: Padding(
          padding: const EdgeInsets.only(top:35.0,left: 15.0,right: 15.0),
          child: Container(
            height: MediaQuery.of(context).size.height/10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('ENT Specialist',style:TextStyle(fontWeight: FontWeight.w700,fontSize:27,color: Colors.white),)),

              ],
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(17)),
            ),


          ),
        ),
    ),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Dermatologist()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top:35.0,left: 15.0,right: 15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text('Dermatologist',style:TextStyle(fontWeight: FontWeight.w700,fontSize:27,color: Colors.white),)),

                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(17)),
                  ),


                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Specialist_in_Gynecology_Obstetmcs()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top:35.0,left: 15.0,right: 15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text('Specialist in Gynecology ',style:TextStyle(fontWeight: FontWeight.w700,fontSize:27,color: Colors.white),)),

                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(17)),
                  ),


                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Specialist_in_Orthopaedics()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top:35.0,left: 15.0,right: 15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text('Specialist in Orthopaedics',style:TextStyle(fontWeight: FontWeight.w700,fontSize:27,color: Colors.white),)),

                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(17)),
                  ),


                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Specialist_in_General_Medicine()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top:35.0,left: 15.0,right: 15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text('Specialist in General Medicine',style:TextStyle(fontWeight: FontWeight.w700,fontSize:27,color: Colors.white),)),

                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(17)),
                  ),


                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Opthalmologist()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top:35.0,left: 15.0,right: 15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text('Opthalmologist',style:TextStyle(fontWeight: FontWeight.w700,fontSize:27,color: Colors.white),)),

                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(17)),
                  ),


                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Pathologist()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top:35.0,left: 15.0,right: 15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text('Pathologist',style:TextStyle(fontWeight: FontWeight.w700,fontSize:27,color: Colors.white),)),

                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(17)),
                  ),


                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Specialist_in_Forensic_Medicine_Toxicology()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top:35.0,left: 15.0,right: 15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text('Specialist in Forensic Medicine',style:TextStyle(fontWeight: FontWeight.w700,fontSize:27,color: Colors.white),)),

                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(17)),
                  ),


                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>heart_specialist()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top:35.0,left: 15.0,right: 15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text('Dentist',style:TextStyle(fontWeight: FontWeight.w700,fontSize:27,color: Colors.white),)),

                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(17)),
                  ),


                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Psychiatrist()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top:35.0,left: 15.0,right: 15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text('Psychiatrist',style:TextStyle(fontWeight: FontWeight.w700,fontSize:27,color: Colors.white),)),

                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(17)),
                  ),


                ),
              ),
            ),



            SizedBox(height: 10,)
          ],
        ),
      ),
    ));
  }
}
