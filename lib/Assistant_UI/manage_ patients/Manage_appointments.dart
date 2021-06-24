import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/manage_%20patients/actions.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'Manage_Patients.dart';

class Manageappointments extends StatefulWidget {
  DocumentSnapshot info;
  Manageappointments({this.info});
  @override
  _ManageappointmentsState createState() => _ManageappointmentsState();
}

class _ManageappointmentsState extends State<Manageappointments> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  String formattedDate;
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthService _auth = AuthService();

  String status_Finish = 'Finished';

  String Status_queued = 'Queued';
  change_status() {
    setState(() {
      Status_queued = 'Finished';
    });
  }

  NavigateData(DocumentSnapshot info) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => actions(
                  info: info,
                )));
  }

  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;
    final uid = user.uid;
    var heigth = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Doctors')
              .doc(widget.info.data()['Doctor_uniqueid'])
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              DocumentSnapshot data1 = snapshot.data;

              String doctor_id = data1['Doctor_id'].toString();
              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title: Text("Manage Appointments",
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      )),
                  leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Manage_patients()));
                      }),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      TableCalendar(
                        focusedDay: selectedDay,
                        firstDay: DateTime(1990),
                        lastDay: DateTime(2050),
                        calendarFormat: format,
                        onFormatChanged: (CalendarFormat _format) {
                          setState(() {
                            format = _format;
                          });
                        },
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        daysOfWeekVisible: true,

                        //Day Changed
                        onDaySelected: (DateTime selectDay, DateTime focusDay) {
                          setState(() {
                            selectedDay = selectDay;
                            focusedDay = focusDay;
                            formattedDate =
                                DateFormat('yyyy-MM-dd').format(focusedDay);
                          });
                          print(formattedDate);
                        },
                        selectedDayPredicate: (DateTime date) {
                          return isSameDay(selectedDay, date);
                        },

                        //To style the Calendar
                        calendarStyle: CalendarStyle(
                          isTodayHighlighted: true,
                          selectedDecoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          selectedTextStyle: TextStyle(color: Colors.white),
                          todayDecoration: BoxDecoration(
                            color: Colors.purpleAccent,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          defaultDecoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          weekendDecoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        headerStyle: HeaderStyle(
                          formatButtonVisible: true,
                          titleCentered: true,
                          formatButtonShowsNext: false,
                          formatButtonDecoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          formatButtonTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('appointments')
                              .doc(doctor_id)
                              .collection('Pending').where("Status",isEqualTo: "1")

                              .where('Date', isEqualTo: formattedDate)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot data =
                                        snapshot.data.docs[index];
                                    String patient_uid =
                                        data['Patient_uid'].toString();
                                    String Date = data['Date'].toString();
                                    return ListTile(
                                      trailing: IconButton(
                                          icon: Icon(
                                            Icons.more_vert_outlined,
                                            color: Colors.blue,
                                            size: 24,
                                          ),
                                          onPressed: () => NavigateData(data)),
                                      minVerticalPadding: 10,
                                      isThreeLine: true,
                                      leading: AvatarLetter(
                                        size: 50,
                                        backgroundColor: Colors.blueAccent,
                                        textColor: Colors.black,
                                        fontSize: 20,
                                        upperCase: true,
                                        numberLetters: 1,
                                        letterType: LetterType.Circular,
                                        text: data["name"],
                                      ),
                                      title: Row(
                                        children: [
                                          Text(data['name'],
                                              style: GoogleFonts.lato(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                              )),
                                          SizedBox(
                                            width: width / 8,
                                          ),
                                          Status(data['Status'].toString()),
                                        ],
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data['description'],
                                              style: GoogleFonts.lato(
                                                color: Colors.blue,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text('On : ' + data['Date'],
                                              style: GoogleFonts.lato(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                              'Serial : ' +
                                                  data['Serial'].toString(),
                                              style: GoogleFonts.lato(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ],
                                      ),
                                    );
                                  });
                            }
                            return CircularProgressIndicator();
                          })
                    ],
                  ),
                ),
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }

  Status(String status) {
    String Status='Cancelled';
    if(status==Status){
      return Text("Cancelled",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600,fontSize: 18),);
    }else if(status=='0'){
      return Text("Pending",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600,fontSize: 18),);
    }else if(status=='1'){
      return Text("Approved",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600,fontSize: 18),);
    }
  }
  void handleClick(String value) {
    switch (value) {
      case 'Finish Appointment':
        change_status();
        final snackBar = SnackBar(
          // Width of the SnackBar.
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
          backgroundColor: Colors.black,
          content: Text('Appointment Finished Successfully'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        break;
    }
  }



}
