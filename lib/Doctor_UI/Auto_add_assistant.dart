import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/Assistants.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/asistant_status.dart';

class auto_add_assistant extends StatefulWidget {
  DocumentSnapshot info;
  auto_add_assistant({this.info});
  @override
  _auto_add_assistantState createState() => _auto_add_assistantState();
}

class _auto_add_assistantState extends State<auto_add_assistant> {
  Navigatedata(DocumentSnapshot info){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>add_assistant(info: info,)));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Assistant Details".toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => Assistants()));
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
                          text: widget.info.data()["Assistant Name"],
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
                                padding: const EdgeInsets.only(top: 25.0),
                                child: Text(
                                  'Assistant Name'.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              Text(
                                widget.info.data()['Assistant Name'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Has Experience of " +
                                    widget.info['Experience'] +
                                    ' years',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.black)),
                                  onPressed: () {},
                                  icon: Icon(Icons.call),
                                  label: Text(
                                    'Call Now',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ))
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
                      widget.info.data()['Email'],
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
                                          "Address",
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
                                          widget.info['Assistant Address'],
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
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
                        Image.asset(
                          "images/map_final.png",
                          width: 180,
                          height: 100,
                        )
                      ],
                    ),
                    Text(
                      "Availability",
                      style: TextStyle(
                          color: Color(0xff242424),
                          fontSize: 28,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Center(
                      child: Row(
                        children: <Widget>[
                          Expanded(

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){
                                  Navigatedata(widget.info);
                                },
                                child: Container(

                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      "Add Assistant".toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20,fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
