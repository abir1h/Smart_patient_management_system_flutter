import 'package:flutter/material.dart';
import 'package:smart_patientmanagement_system/Alerts&Loaders/signuperrordialog.dart';

import 'alert_dialog.dart';
class Dialog_Helper {

  static alert(context) => showDialog(context: context, builder: (context) => signuperror());
}