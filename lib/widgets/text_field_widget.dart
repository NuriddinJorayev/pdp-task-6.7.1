import 'package:flutter/material.dart';

class Text_field_widget {
  
  Widget build(text, controller, Widget visible, [bool texttype = false]) => Container(
    height: 60.0,
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: TextField(
          controller: controller,
          obscuringCharacter: '*',
          obscureText: texttype,
          decoration: InputDecoration(
            hintText: text,
            hintStyle: TextStyle(color: Colors.grey[600], letterSpacing: 0.8, fontWeight: FontWeight.w600),
            suffixIcon: visible
          ),
        ),
      );
}
