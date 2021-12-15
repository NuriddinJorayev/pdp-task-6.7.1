import 'package:flutter/material.dart';

class Text_Builder {
  Widget build(text1, text2, Function() f) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text1,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),

          SizedBox(width: 10.0),

          InkWell(
            onTap: f,
            child: Text(
              text2,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
          ),

          SizedBox(width: 15.0),
        ],
      );
}
