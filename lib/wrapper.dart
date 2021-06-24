

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_patientmanagement_system/auth_helper/user.dart';

import 'Assistant_UI/Asstant_hoem_page.dart';
import 'Doctor_UI/Dashboard.dart';
import 'Patient_Ui/Homepage.dart';
import 'Starter/Authenticate.dart';

String role;

class wrapper extends StatefulWidget {
  @override
  _wrapperState createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {
  Future _data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data= get_user_pref();
  }
  get_user_pref() async {
    final SharedPreferences sharedpreferences =
    await SharedPreferences.getInstance();
    var role_ofuser = sharedpreferences.getString('Role');
    role = role_ofuser;
    return role;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User_model>(context);
    print(user);

// return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      if (role == 'Doctor') {
        return Dashboard();
      } else if (role == 'Patient') {
        return Homepage();
      }else if (role == 'Assistant') {
        return assistant_homepage();
      }
    }
  }
}

