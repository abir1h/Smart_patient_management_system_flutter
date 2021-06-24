import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_patientmanagement_system/auth_helper/auth.dart';

import 'Speciality.dart';

class CheckboxWidget extends StatefulWidget {
  @override
  CheckboxWidgetState createState() => new CheckboxWidgetState();
}

class CheckboxWidgetState extends State {

  Map<String, bool> values = {
    'Apple': false,
    'Banana': false,
    'Cherry': false,
    'Mango': false,
    'Orange': false,
  };

  List<String> tmpArray=[];

  getCheckboxItems()async{

    values.forEach((key, value) {
      if(value == true)
      {
        tmpArray.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    Navigator.pop(context,tmpArray);


    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    tmpArray.clear();

  }

  @override
  Widget build(BuildContext context) {
    return Column (children: <Widget>[

      ElevatedButton(
        child: Text(" Get Selected Checkbox Items ", style: TextStyle(fontSize: 18),),
        onPressed: getCheckboxItems,

      ),

      Expanded(
        child :
        ListView(
          children: values.keys.map((String key) {
            return new CheckboxListTile(
              title: new Text(key),
              value: values[key],
              activeColor: Colors.pink,
              checkColor: Colors.white,
              onChanged: (bool value) {
                setState(() {
                  values[key] = value;
                });
              },
            );
          }).toList(),
        ),
      ),]);
  }
}