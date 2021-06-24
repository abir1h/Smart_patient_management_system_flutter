import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smart_patientmanagement_system/Patient_Ui/Homepage.dart';

import 'book appointment.dart';

class doctor_details extends StatefulWidget {
  DocumentSnapshot info;
  doctor_details({this.info});
  @override
  _doctor_detailsState createState() => _doctor_detailsState();
}

class _doctor_detailsState extends State<doctor_details> {
  Navigatedata(DocumentSnapshot info){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>BookingScreen(info: info,)));
  }

  @override
  Widget build(BuildContext context) {

    double c_width = MediaQuery.of(context).size.width*0.8;
    String phone=widget.info['Mobile'];
    return SafeArea(child: Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
         Navigatedata(widget.info);
        },
        label: Text('Make Appointment',style: TextStyle(fontWeight: FontWeight.w500),),
        icon: Icon(Icons.work),
        backgroundColor: Colors.blue,
        splashColor: Colors.orangeAccent,
      ),
      appBar: AppBar(

        title: Text('Doctor Details'.toUpperCase(),style: TextStyle(fontWeight: FontWeight.w900),),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Homepage()));
        }),
      ),
      body: SingleChildScrollView(

        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  AvatarLetter(
                    size: 70,
                    backgroundColor: Colors.blueAccent,
                    textColor: Colors.white,
                    fontSize: 30,
                    upperCase: true,
                    numberLetters: 1,
                    letterType: LetterType.Circular,
                    text: widget.info.data()["Doctor_Full_Name"],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 222,
                    height: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Doctor Name'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Text(
                          widget.info.data()['Doctor_Full_Name'],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        Text(

                              widget.info['Speciality'] ,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400,color: Colors.blue
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue)),
                                  onPressed: () {
                                    launch("tel://$phone");
                                  },
                                  icon: Icon(Icons.call),
                                  label: Text(
                                    'Call Now',
                                    style:
                                    TextStyle(fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 26,
              ),
              Row(
                children: [
                  Icon(
                    Icons.work,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Bio",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                widget.info['About'],
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_history,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Chamber Address",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width -
                                    268,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(left: 35.0),
                                  child: Text(
                                    widget.info['ChamberAdress'],
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black,fontWeight: FontWeight.w900),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 40.0,
                  ),
                  Expanded(
                    child: Image.asset(
                      "images/map_final.png",
                      width: 100,
                      height: 100,
                    ),
                  )
                ],
              ),
              Text(
                "Other Information",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 22,
              ),
              Column(children: [
                Row(
                  children: [
                    Text('Working Hours  :  ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                    Text(widget.info.data()['Chamber_Opening_Time'] + '-'+ widget.info.data()['Chamber_Closing_Time'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),)
                  ],
                ),Row(
                  children: [
                    Text('Contact Number  :  ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                    Text(widget.info.data()['Mobile'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),)
                  ],
                ),
                Row(
                  children: [
                    Text('Email  :  ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                    Text(widget.info.data()['Email'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),)
                  ],
                ),
                Row(
                  children: [
                    Text('Gender  :  ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                    Text(widget.info.data()['Gender'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),)
                  ],
                ),
                Row(
                  children: [
                    Text('Age  :  ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                    Text(widget.info.data()['Age'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),)
                  ],
                )
              ],)

            ],
          ),
        ),
      ),
    ));
  }


}
