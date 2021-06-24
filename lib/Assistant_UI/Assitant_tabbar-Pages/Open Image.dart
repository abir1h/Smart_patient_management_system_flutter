import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/Asstant_hoem_page.dart';
class open_image extends StatefulWidget {
  String info;
  open_image({this.info});
  @override
  _open_imageState createState() => _open_imageState();
}

class _open_imageState extends State<open_image> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:
    AppBar(leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>assistant_homepage()));
    },)
      ,),
    body: PhotoView(
      imageProvider: NetworkImage(widget.info) ,
    ),
    );
  }
}
