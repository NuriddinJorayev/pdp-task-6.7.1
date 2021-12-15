import 'package:flutter/material.dart';
import 'package:herewego/pages/sing_in_page.dart';
import 'package:herewego/service/authservice.dart';
import 'package:herewego/service/prefs.dart';

class Home extends StatefulWidget {
  final String id = "home_page";
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("home Page"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("welcome to home page"),
              ElevatedButton(
                onPressed: (){
                   Prefs.isExist().then((value) => _logOut(value));
                },
                child: Text(
                  "Log Out",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _logOut(bool exist){
   if(exist){
      AuthService.Loguot(context);
   }
    
  }
}
