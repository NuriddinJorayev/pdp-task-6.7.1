// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Firebase_Storage{
  static final store =  FirebaseStorage.instance.ref();
  static final folder = "post_images";

 static Future<String> UpLoad(File _image) async{
   String img_name = "image_" + DateTime.now().toString();
   Reference firebaseStorageRef =await store.child(folder).child(img_name);
   UploadTask uploadTask = firebaseStorageRef.putFile(_image);
   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => (){});
   if (taskSnapshot != null){
     String downloadUrl = await taskSnapshot.ref.getDownloadURL();
     print(downloadUrl);
     return downloadUrl;
   }
    return '';
  }
}