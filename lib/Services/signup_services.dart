// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_count/Pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


signUpUser(
  String userName,
  String userEmail, 
  String userPassword,
  ) {
    User? userid = FirebaseAuth.instance.currentUser;
  try{
         FirebaseFirestore.instance.collection('Users').doc(userid!.uid).set({
                    'userName': userName,
                    'userEmail': userEmail,
                    'createdAt': DateTime.now(),
                    'userId': userid.uid,
                    }).then((value)=>{
                      FirebaseAuth.instance.signOut(),
                      Get.offAll(()=> LoginPage()),
                    });
  } on FirebaseAuthException catch(e){
    print('Error $e');
  }


  }