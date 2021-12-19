// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/home_page.dart';
import 'package:herewego/pages/sign_up_page.dart';
import 'package:herewego/service/authservice.dart';
import 'package:herewego/service/prefs.dart';
import 'package:herewego/widgets/button_widget.dart';
import 'package:herewego/widgets/text_field_widget.dart';
import 'package:herewego/widgets/text_widget.dart';
import 'package:herewego/widgets/toast.dart';

class SignInPage extends StatefulWidget {
  final String id = 'SignInPage';
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var control1 = TextEditingController();
  var control2 = TextEditingController();
  IconData IconVisible = Icons.visibility_off_outlined;
  bool isloading = false;
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    Size AllSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: AllSize.height,
          width: AllSize.width,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Stack(
              children: [
                isloading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox.shrink(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text_field_widget()
                        .build("Email", control1, SizedBox.shrink()),
                    Text_field_widget().build("Password", control2, _visible(), visible),
                    Button_Builder().build("Sign In", () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _isloading_chacker();
                      _DoSignin();
                    }),
                    SizedBox(height: 20.0),
                    Text_Builder().build(
                        "Don't have an account?", "Sign Up", () => _OpenPage())
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _isloading_chacker() {
    setState(() {
      if (isloading) {
        isloading = false;
      } else {
        isloading = true;
      }
    });
  }

  Widget _visible() {
    return IconButton(onPressed: () {
      setState(() {
        if (visible){
          visible = false;
          IconVisible = Icons.visibility_outlined;
        }else{
          visible = true;
          IconVisible = Icons.visibility_off_outlined;
        }
      });
    }, icon: Icon(IconVisible));
  }

  _DoSignin() {
    String email = control1.text;
    String password = control2.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      AuthService.SignInUser(context, email, password)
          .then((user) => _loadUser(user));
    }
  }

  _loadUser(User user) {
    if (user != null) {
      Prefs.SaveUserId(user.uid);
      _isloading_chacker();
      Navigator.pushReplacementNamed(context, Home().id);
    } else {
      setState(() {
        isloading = false;
      });
      Toast_widget.build("Email or Password incorrect", context);
    }
  }

  void _OpenPage() {
    Navigator.pushReplacementNamed(context, SignUpPage().id);
  }
}
