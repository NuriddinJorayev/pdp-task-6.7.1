import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:herewego/models/post.dart';
import 'package:herewego/service/prefs.dart';
import 'package:herewego/service/rtdb_service.dart';
import 'package:herewego/service/storeage_service.dart';
import 'package:herewego/widgets/toast.dart';
import 'package:image_picker/image_picker.dart';

class Detail_page extends StatefulWidget {
  const Detail_page({Key? key}) : super(key: key);

  @override
  _Detail_pageState createState() => _Detail_pageState();
}

class _Detail_pageState extends State<Detail_page> {
  bool isLoading = false;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  var control1 = TextEditingController();
  var control2 = TextEditingController();
  var control3 = TextEditingController();
  var control4 = TextEditingController();
 

  @override
  Widget build(BuildContext context) {
    Size allSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Post"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, "");
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Color.fromARGB(255, 255, 87, 32),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              height: allSize.height,
              width: allSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.0),
                  InkWell(
                    onTap: _getImage,
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(border: Border.all(width: 1.0)),
                      child: _image != null
                          ? Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "assets/images/ic_default.png",
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  _Textfield_builder("Firstname", control1),
                  _Textfield_builder("Lastname", control2),
                  _Textfield_builder("Content", control3),
                  _Textfield_builder("Date", control4),
                  SizedBox(height: 10.0),
                  MaterialButton(
                    color: Color.fromARGB(255, 255, 87, 32),
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      _addAll();
                    },
                    child: Container(
                      height: 48.0,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Add",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),               
                ],
              ),
            ),
              isLoading
                  ? Container(
                      height: allSize.height,
                      width: allSize.width,
                      color: Colors.orange[900]!.withOpacity(.4),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.orange[900],
                        ),
                      ),
                    )
                  : SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  _Exit() {
    Navigator.of(context).pop("data");
  }

  Future _getImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  // first image save in firebaseStorage
  _addAll() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (control1.text.isEmpty ||
        control2.text.isEmpty ||
        control3.text.isEmpty ||
        control4.text.isEmpty) { _addPost(""); return;}
   else if (_image != null) {
      
      Firebase_Storage.UpLoad(_image!).then((value) => _addPost(value));
    }else{
      Toast_widget.build("you have to take a picture", context);
      setState(() {
        isLoading = false;
      });
    }
  }

  // run by _addAll function, save RealTimeDetabase and _Exit
  _addPost(String url) async {
    
    if (control1.text.isNotEmpty &&
        control2.text.isNotEmpty &&
        control3.text.isNotEmpty &&
        control4.text.isNotEmpty) {
      var id = await Prefs.LoadUserId();

      RTDB_Service.StorePost(Post(
          userId: id,
          firstName: control1.text,
          lastName: control2.text,
          content: control3.text,
          date: control4.text,
          // ignore: unnecessary_null_comparison
          image: url));
      FirebaseDatabase.instance.ref().onChildAdded.listen((event) {
        setState(() {
          isLoading = false;
        });
        _Exit();
      });
    } else {
      setState(() {
        isLoading = false;
      });
      Toast_widget.build(
          "chack your textfield, someone is empty", this.context);

    }
  }

  Widget _Textfield_builder(text, controller) {
    return Container(
      height: 60.0,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: text,
            hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.8)),
      ),
    );
  }
}
