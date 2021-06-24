import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/Assistant_patients.dart';
import 'package:smart_patientmanagement_system/Doctor_tabbar_pages/Basic_Info.dart';
import 'package:smart_patientmanagement_system/Doctor_tabbar_pages/Prescriptions_tab.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

import 'Assitant_tabbar-Pages/basicInfo.dart';
import 'Assitant_tabbar-Pages/prescriptions_tab_assistant.dart';
import 'Asstant_hoem_page.dart';
class Assistant_patietnDetails extends StatefulWidget {
  final DocumentSnapshot info;

  Assistant_patietnDetails({this.info});
  @override
  _Assistant_patietnDetailsState createState() => _Assistant_patietnDetailsState();
}

class _Assistant_patietnDetailsState extends State<Assistant_patietnDetails>
    with SingleTickerProviderStateMixin {

  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton<String>(
                onSelected: handleClick
                ,itemBuilder: (BuildContext context){
              return{'Delete Patient'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            }  )
          ],
          backgroundColor: Colors.blue,
          centerTitle: true,
          bottom: TabBar(
            controller: tabController,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.black,
            isScrollable: true,
            labelColor: Colors.white,
            indicatorWeight: 8,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                text: 'BASIC INFO'.toUpperCase(),
              ),
              Tab(
                text: 'Visits'.toUpperCase(),
              ),
              Tab(
                text: 'Prescription'.toUpperCase(),
              ),
              Tab(
                text: 'Other Details'.toUpperCase(),
              ),
            ],
          ),
          title: Column(
            children: [
              Text(
                widget.info.data()['Patient_Name'],
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                'Patient Details',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => assistant_homepage()));
              }),
        ),
        body: TabBarView(


          controller: tabController,
          children: [

            Assitant_Basicinfo(info: widget.info,),
            Center(child: Text(widget.info.data()['Phone'])),
            prescription_assistant_tab(info: widget.info,),
            Center(child: Text('Basic Info')),
          ],
        ),
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Delete Patient':
        String uid= widget.info.data()['Doctor_uniqueid'];
        String Phone= widget.info.data()['Phone'];
        getdocumetnid(uid,Phone);
        final snackBar = SnackBar(
          // Width of the SnackBar.
            duration: Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
            backgroundColor: Colors.black,
            content: Text('Patient has been Deleted Successfully'),
            action: SnackBarAction(
              label: 'Dismiss',
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>assistant_homepage()));
              },
            )
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>assistant_homepage()));

        break;

    }
  }
}

Future getdocumetnid(String uid,String Phone) async{



  var doc_ref = await FirebaseFirestore.instance.collection("Under_doctor_patients").doc(uid).collection('patients')
 .where('Phone',isEqualTo: Phone).get();
  doc_ref.docs.forEach((result) {

    FirebaseFirestore.instance.collection("Under_doctor_patients").doc(uid).collection('patients').doc(result.id).delete();

  }
  );

}
