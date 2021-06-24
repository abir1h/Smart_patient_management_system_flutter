import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

import 'Asstant_hoem_page.dart';
class Assistant_profile extends StatefulWidget {

  @override
  _Assistant_profileState createState() => _Assistant_profileState();
}

class _Assistant_profileState extends State<Assistant_profile> {
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;
    final uid = user.uid;
    return SafeArea(child: StreamBuilder<Object>(
      stream: FirebaseFirestore.instance.collection('Assistants').doc(uid).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.data!= null){
          DocumentSnapshot data=snapshot.data;
          return Scaffold(
            appBar: AppBar(

              title: Text('Assistant Details'.toUpperCase(),style: TextStyle(fontWeight: FontWeight.w900),),
              leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>assistant_homepage()));
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
                          text: data['Assistant Name'],
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
                              ),SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                   data['Assistant Name'],
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.w700),
                                  ),

                                ],
                              ),
                              Text(
                                "Phone     " +
                                   data['Mobile'] ,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 40,
                              ),

                            ],
                          ),
                        ),
                      ],
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
                        Row(
                          children: [
                            Text(
                              "Bio",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ), IconButton(icon: Icon(Icons.edit), onPressed: (){
                              showAlertDialogBio(context,data);
                            })
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                     data['About'],
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
                                        Row(
                                          children: [
                                            Text(
                                              "Address",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ), IconButton(icon: Icon(Icons.edit), onPressed: (){showAlertDialogAddress(context, data); })
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          268,
                                      child: Text(
                                        data['Assistant Address'],
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),


                      ],
                    ),   SizedBox(height: 5,),
                    Row(
                      children: [


                        Text(
                          "Other Information",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        ),
                        IconButton(icon: Icon(Icons.edit), onPressed: (){})
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: Column(children: [
                        Row(
                          children: [
                            Text('Contact Number  :  ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                            Text(data['Mobile'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),)
                          ],
                        ),
                        Row(
                          children: [
                            Text('Email  :  ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                            Text(data['Email'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),)
                          ],
                        ),
                        Row(
                          children: [
                            Text('Gender  :  ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                            Text(data['Gender'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),)
                          ],
                        ),
                        Row(
                          children: [
                            Text('Age  :  ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                            Text(data['Age'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),)
                          ],
                        ) ,
                      ],),
                    )

                  ],
                ),
              ),
            ),
          );
        }return CircularProgressIndicator();
      }
    ));
  }
}


showAlertDialog(BuildContext context, DocumentSnapshot data,
    ) {
  // set up the button
  TextEditingController controller=TextEditingController();
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Change Name'),
    content: TextField(
      decoration: InputDecoration(
        hintText: 'Enter Name',
      ),
      controller: controller,
    ),
    actions: [
      TextButton(
          onPressed: () async {
            String Name=controller.text;
            List<String> splitlist = Name.split(' ');
            List<String> indexlist = [];
            for (int i = 0; i < splitlist.length; i++) {
              for (int j = 0; j <= splitlist[i].length + i; j++) {
                indexlist.add(splitlist[i].substring(0, j).toLowerCase());
              }
            }
            final AuthService _auth = AuthService();
            final uid = await _auth.getCurrenbtUid();
            FirebaseFirestore.instance.collection("Doctor_Asistants").doc(data['Assistant_uid']).update({
              'Assistant Name': Name,
              'searchindex': indexlist,
            });
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>assistant_homepage()));
          },
          child: Text('Update'.toUpperCase()))
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogBio(BuildContext context, DocumentSnapshot data,
    ) {
  // set up the button
  TextEditingController controller=TextEditingController();
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('About'),
    content: TextField(
      decoration: InputDecoration(
        hintText: 'Write Your Bio',
      ),
      controller: controller,
    ),
    actions: [
      TextButton(
          onPressed: () async {
            String Name=controller.text;

            final AuthService _auth = AuthService();
            final uid = await _auth.getCurrenbtUid();
            FirebaseFirestore.instance.collection("Assistants").doc(uid).update({
              'About': Name,

            });
           Navigator.pop(context);

          },
          child: Text('Update'.toUpperCase()))
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
showAlertDialogAddress(BuildContext context, DocumentSnapshot info,
    ) {
  // set up the button
  TextEditingController controller=TextEditingController();
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Address'),
    content: TextField(
      decoration: InputDecoration(
        hintText: 'Change Address',
      ),
      controller: controller,
    ),
    actions: [
      TextButton(
          onPressed: () async {
            String Name=controller.text;

            final AuthService _auth = AuthService();
            final uid = await _auth.getCurrenbtUid();
            FirebaseFirestore.instance.collection("Assistants").doc(uid).update({
              'Assistant Address': Name,

            });
            Navigator.pop(context);

          },
          child: Text('Update'.toUpperCase()))
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
ShowotherDialog(BuildContext context) {
  TextEditingController controller=TextEditingController();


  // set up the AlertDialog
  AlertDialog alert = AlertDialog(

    title: Text('Edit Other Details'),
    content: Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter Number',
          ),
          controller: controller,
        ), TextField(
          decoration: InputDecoration(
            hintText: 'Enter Chamber Name',
          ),
          controller: controller,
        ),

      ],
    ),
    actions: [
      TextButton(
          onPressed: () async {
            String Phone=controller.text;



            final AuthService _auth = AuthService();
            final uid = await _auth.getCurrenbtUid();
            FirebaseFirestore.instance.collection("Doctor_Asistants").doc(uid).update({
              'Mobile': Phone,



            });
            Navigator.pop(context);
          },
          child: Text('Update'.toUpperCase()))
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}