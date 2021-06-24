import 'package:flutter/material.dart';

import 'alert_dialog.dart';
class DialogHelper {

  static alert(context) => showDialog(context: context, builder: (context) => alert_dialog());
}