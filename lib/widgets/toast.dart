
// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

class Toast_widget{
  static build(msg, BuildContext context){
    Toast.show(
      msg,
      context,
      gravity: Toast.BOTTOM,
      duration: Toast.LENGTH_LONG);

  }
}