// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:demo_count/Pages/signup_page.dart';
import 'package:demo_count/Pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {


Future redirect() async{
   Get.offAll(()=>(SignupPage()));
}
//text controller
final _emailcontroller = TextEditingController();
final _passwordcontroller = TextEditingController();

Future signIn() async{
  showDialog(context: context, builder: (context){
    return Center(child: CircularProgressIndicator());
  },
  );
  try{
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _emailcontroller.text.trim(), 
    password: _passwordcontroller.text.trim() );
    Navigator.of(context).pop();
    Get.to(()=>HomeScreen());
} on FirebaseAuthException {
     Navigator.of(context).pop(); // Close the loading dialog
      _showErrorDialog();
    }
  }
    // Show error dialog
  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Login Failed"),
          content: Text(' Wrong Email id or Password '),
          actions: [
            TextButton(
              onPressed: () {
               Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }




@override
void dispose(){
  _emailcontroller.dispose();
  _passwordcontroller.dispose();
  super.dispose();
}
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 219, 214, 214),
      body:  SafeArea(
        child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const Icon(Icons.adb_rounded,
            size: 150,),
           const SizedBox(height: 20,),
              //welcome msg
          
               Text("Hello there",
              style: GoogleFonts.bebasNeue(
                fontSize: 50
              ),
            ),
            SizedBox(height: 15,),
            Text("Welcome again",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            SizedBox(height: 50,),
            
            //email column
          
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 245, 237, 237),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: TextField(
                    controller: _emailcontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email" 
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
          
            //password colmn
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container( decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: TextField(
                    controller: _passwordcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password"
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: signIn,
                child: Container( 
                  padding:EdgeInsets.all(15),
                  decoration:  BoxDecoration(
                  color: Color.fromARGB(255, 69, 134, 31),
                  borderRadius: BorderRadius.circular(12),
                ),
                  child: Center(
                    child: Text('Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold, fontSize: 18,
                    ),),
                  )
                  ),
              ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(" join us? ",
                  style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 16,
                  ),
                  ),
                  GestureDetector(
                    onTap: redirect,
                    child: Text("Register Now!",
                    style: TextStyle(fontWeight:  FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromARGB(255, 69, 134, 315) )
                      ),
                      ),
                      ]
                  )
            ],
                ),
        ),

    )
    ),
    );


  }
}