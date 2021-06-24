

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_patientmanagement_system/Doctor_UI/patients.dart';
import 'package:smart_patientmanagement_system/Doctor_tabbar_pages/Prescriptions_tab.dart';
class opens_image extends StatefulWidget {
  String url;
  opens_image({@required this.url});
   @override
  _opens_imageState createState() => _opens_imageState();
}

class _opens_imageState extends State<opens_image> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>patients()));
        }),
      ),
      body:PhotoView(
        imageProvider: NetworkImage(widget.url) ,
      )
    );
  }
}

