
// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/home_page.dart';
import 'package:herewego/pages/sing_in_page.dart';
import 'package:herewego/service/authservice.dart';
import 'package:herewego/service/prefs.dart';
import 'package:herewego/widgets/button_widget.dart';
import 'package:herewego/widgets/text_field_widget.dart';
import 'package:herewego/widgets/text_widget.dart';
import 'package:herewego/widgets/toast.dart';

class SignUpPage extends StatefulWidget {
  final String id = 'SignUpPage';
  const SignUpPage({ Key? key }) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var control1 = TextEditingController();
  var control2 = TextEditingController();
  var control3 = TextEditingController();
  bool isloading = false;
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
                isloading ? Center(child: CircularProgressIndicator(),) : SizedBox.shrink(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text_field_widget().build("Fullname", control1),
                    Text_field_widget().build("Email", control2),
                    Text_field_widget().build("Password", control3, true),
                    Button_Builder().build("Sign Up", () => {
                      _isloading_chacker(),
                      _DoSignup()
                    }),
                    SizedBox(height: 20.0),
                    Text_Builder().build("Already have an account?", "Sign in", () => _OpenPage())
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _isloading_chacker(){
    setState(() {
      if(isloading){
        isloading = false;
      }else{
        isloading = true;
      }
    });
  }

  _DoSignup(){
    String email = control2.text;
    String password = control3.text;
    if (email.isNotEmpty && password.isNotEmpty){
      AuthService.SignUpUser(context, email, password).then((user) => _loadUser(user));
    }
  }

  _loadUser(User user){
    if(user != null){
      Prefs.SaveUserId(user.uid);
      _isloading_chacker();
      Navigator.pushReplacementNamed(context, Home().id);
    }else{
      setState(() {
        isloading = false;
      });
      Toast_widget.build("Chack your Email or password", context);
    }
  }

  _OpenPage(){
    Navigator.pushReplacementNamed(context, SignInPage().id);
  }
}