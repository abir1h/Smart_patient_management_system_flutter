import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_patientmanagement_system/Patient_Ui/Homepage.dart';
import 'package:smart_patientmanagement_system/Patient_Ui/prescriptions.dart';
class opens_image_patients extends StatefulWidget {
  String url;
  opens_image_patients({@required this.url});
  @override
  _opens_image_patientsState createState() => _opens_image_patientsState();
}

class _opens_image_patientsState extends State<opens_image_patients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Homepage()));
          }),
        ),
        body:PhotoView( )
    );
  }
}
