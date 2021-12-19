import 'package:flutter/material.dart';

class Button_Builder {
  Widget build(text, Function() f) => MaterialButton(
  color:  Colors.orange[900],
        onPressed: f,
        child: Container(
          height: 45.0,
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0),
            ),
          ),
        ),
      );
}
