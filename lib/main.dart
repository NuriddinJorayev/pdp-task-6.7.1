import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/home_page.dart';
import 'package:herewego/pages/sign_up_page.dart';
import 'package:herewego/pages/sing_in_page.dart';
import 'package:herewego/service/prefs.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
      ),
      home: _StartPage(),
      routes: {
        Home().id : (context) => Home(),
        SignInPage().id : (context) => SignInPage(),
        SignUpPage().id : (context) => SignUpPage(),
      },
    );
  }

  Widget _StartPage(){
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext ctx, snap){
        if(snap.hasData){
          Prefs.SaveUserId(snap.data!.uid);
          return Home();
        }else return SignInPage();
      },
    );
  }
}
