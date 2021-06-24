import 'package:flutter/material.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/assitant_reg.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Register_Assistants.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/doctor_signup.dart';
import 'package:smart_patientmanagement_system/Patient_Ui/Register_patients.dart';

class whoareyou extends StatefulWidget {
  @override
  _whoareyouState createState() => _whoareyouState();
}

class _whoareyouState extends State<whoareyou> {
  @override
  Widget build(BuildContext context) {

    var screenWidth =  MediaQuery.of(context).size.width;
    var screenHeight =  MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(top:100.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:50.0),
                    child: Row(
                      children: [
                        Text("Are you a Doctor?",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(

                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context){
                                  return docotr_signup();
                                }));

                              },
                              child: Container(

                                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.blue,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Get Started",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600, color: Colors.white),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),

                            ),
                          ),

                        ),

                      ],
                    ),
                  ),
                  Text(
                    'Or'.toUpperCase(),style: TextStyle(
                    fontFamily: 'AveriaLibre-Bold',
                    fontSize: 22,color: Colors.blue,
                    fontWeight: FontWeight.w900,
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:50.0),
                    child: Row(
                      children: [
                        Text("Are you a Patient?",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(

                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context){
                                  return patient_sign_up();
                                }));

                              },
                              child: Container(

                                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.blue,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Get Started",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600, color: Colors.white),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),

                            ),
                          ),

                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Row(
                      children: [
                        TextButton(child: Text("If You are an Assistant Tap here",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20)),onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context){
                            return assistant_register();
                          }));
                        }),


                      ],
                    ),
                  ),


                ],
              ),
            ),
          )
          ),
        );
  }
}
