import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_patientmanagement_system/Patient_Ui/Approved%20Appointments.dart';
import 'package:smart_patientmanagement_system/Patient_Ui/Requsted%20Appointments.dart';

import 'Homepage.dart';
class appointments extends StatefulWidget {
  @override
  _appointmentsState createState() => _appointmentsState();
}

class _appointmentsState extends State<appointments> {
  @override
  Widget build(BuildContext context) {
    var heigth= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Appointments"),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Homepage()));
        }),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              child: Image(
                image: AssetImage('images/pnpn.jpg'),
                height: heigth/2,
              ),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 2,
                primary: Colors.blue,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>approved_appointments()));
              }, child: Text('Approved Appointments', style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),)  ) ,SizedBox(height: heigth/15,),ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 2,
                primary: Colors.blue,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Requsted_appointments()));
              }, child: Text('Requested  Appointments', style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),)  )
        ],
      ),
    )

      ,);
  }
}
