// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_count/Pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import '../Services/firebase_options.dart';

Future<void> main() async {
 await dotenv.load(fileName: ".env");
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
}
class HomeScreen extends StatefulWidget {
  const HomeScreen ({super.key});


  @override
  State<HomeScreen> createState() => _HomeSCreen();
}

class _HomeSCreen extends State<HomeScreen> {
User? userId= FirebaseAuth.instance.currentUser;
int _counter = 0;

  // Retrieve the stored value from Firebase when the app initializes
  @override
  void initState() {
    super.initState();
    _fetchStoredCounter();
  }

  // Fetch the counter value from Firebase

  bool _isLoading = true;
  
  Future<void> _fetchStoredCounter() async {
    var doc = await FirebaseFirestore.instance
        .collection('Counts')
        .doc(userId?.uid)
        .get();
    
    setState(() {
      if (doc.exists){
        _counter = doc.data()?['value']?? 0;
      } else {
        _counter = 0;
      }
      _isLoading = false;
    });
  }

//increment the counter and store in firebase

void _incrementCounter() async{
  setState(() {
    _counter++;
  });
  await FirebaseFirestore.instance.collection('Counts').doc(userId?.uid).set({
    "value": _counter,
    "userId": userId?.uid
  });
}
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 186, 206, 225),
        title: Text("Counter"),
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.offAll(() => LoginPage());
            },
            child: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(

        child: _isLoading ? CircularProgressIndicator():
         Text(
          'You have pressed the button $_counter times',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
