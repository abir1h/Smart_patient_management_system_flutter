import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_patientmanagement_system/Assistant_UI/Assitant_tabbar-Pages/Open%20Image.dart';

class prescription_assistant_tab extends StatefulWidget {
  DocumentSnapshot info;

  prescription_assistant_tab({this.info});
  @override
  _prescription_assistant_tabState createState() => _prescription_assistant_tabState();
}

class _prescription_assistant_tabState extends State<prescription_assistant_tab> {
  final firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser;
    final uid = user.uid;
    var data = widget.info;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection('Prescriptions')
            .where('Patient_phone', isEqualTo: widget.info.data()["Phone"])
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();

          return _buildList(context, snapshot.data.docs);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage(widget.info);
        },
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList());
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  Navigatedata(String info){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>open_image(info:  info,)));
  }
  final record = Record.fromSnapshot(data);
  String imageurl=record.url;

  return Padding(
    key: ValueKey(record.location),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        onTap: (){
          Navigatedata(imageurl);
        },

        title: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                record.location,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),

            Image.network(record.url),
            Text('Created at'+ record.Patient_phone)

          ],
        ),
      ),
    ),
  );
}

Future getImage(DocumentSnapshot info) async {
  // Get image from gallery.
  var image = File(await ImagePicker()
      .getImage(source: ImageSource.gallery)
      .then((pickedFile) => pickedFile.path));

  _uploadImageToFirebase(image, info);
}

Future<void> _uploadImageToFirebase(File image, DocumentSnapshot info) async {
  try {
    // Make random image name.

    String imageLocation =
        'images/image${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';

    // Upload image to firebase.
    FirebaseStorage storage = FirebaseStorage.instance;
    final Reference ref = storage.ref().child(imageLocation);
    final UploadTask uploadTask = ref.putFile(image);
    await uploadTask
        .whenComplete(() => _addPathToDatabase(imageLocation, info));
  } catch (e) {
    print(e.message);
  }
}

Future<void> _addPathToDatabase(String text, DocumentSnapshot info) async {
  String phone = info.data()['Phone'];


  FirebaseAuth auth = FirebaseAuth.instance;
  final uid = auth.currentUser.uid;
  try {
    // Get image URL from firebase
    FirebaseStorage storage = FirebaseStorage.instance;
    final ref = storage.ref().child(text);
    var imageString = await ref.getDownloadURL();

    // Add location and url to database
    await FirebaseFirestore.instance.collection('Prescriptions').doc().set({
      'url': imageString,
      'location': text,
      'Patient_phone': phone,
      'created_at': FieldValue.serverTimestamp(),
    });
  } catch (e) {
    print(e.message);
  }
}

class Record {
  final String Patient_phone;
  final String location;
  final String url;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['location'] != null),
        assert(map['url'] != null),
        assert(map['Patient_phone'] != null),

        location = map['location'],
        Patient_phone = map['Patient_phone'],

        url = map['url'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$location:$url:$Patient_phone>";
}
