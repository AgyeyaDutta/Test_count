
// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:demo_count/Pages/login_page.dart';
import 'package:demo_count/Services/signup_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

Future redirect() async{
   Get.offAll(()=>(LoginPage()));
}

Future signUp() async{
  showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text("Welcome aboard, Login Now"),
      content: Text('Please make sure you used the correct format for your email'),
      actions: [
        TextButton(onPressed: (){
        Navigator.of(context).pop();
        },
         child: Text('ok'))
      ],
    );
    
  },
  );
   var userName = userNameController.text.trim();
   var userEmail = userEmailController.text.trim();
   var userPassword = userPasswordController.text.trim();
   FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: userEmail , password: userPassword).then((value)=>{
      signUpUser(userName, userEmail, userPassword,)});
}
  //text controllers

  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  
  User? currentUser = FirebaseAuth.instance.currentUser;

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 214, 214),
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
          
               Text("Hey there!",
              style: GoogleFonts.bebasNeue(
                fontSize: 50
              ),
                ),
                const SizedBox(height: 10,),
                const Text("Welcome to Demo Counter",
              style: TextStyle(
                fontSize:18,
                fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50,),
          
                //email colum
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:  Padding(
                    padding:const EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      controller: userNameController,
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              
              //password column
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      controller: userEmailController,
                      decoration:const InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
               const SizedBox(height: 20,),
          
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
                 child: Container(
                  decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child:  TextFormField(
                      controller: userPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password, atleast 6 characters',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                 ),
               ),
                const SizedBox(height: 20,),

             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: signUp,
                child: Container( 
                  padding:EdgeInsets.all(15),
                  decoration:  BoxDecoration(
                  color: Color.fromARGB(255, 69, 134, 31),
                  borderRadius: BorderRadius.circular(12),
                ),
                  child: Center(
                    child: Text('Sign up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold, fontSize: 18,
                    ),),
                  )
                  ),
              ),
              ),
              SizedBox(height: 20,),
          
              //new member
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already an user? ",
                  style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 16,
                  ),
                  ),
                  GestureDetector(
                    onTap: redirect,
                    child: Text("Sign in",
                    style: TextStyle(fontWeight:  FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromARGB(255, 69, 134, 31) )
                      ),
                      ),
                      ]
                  )
                ],
              ),
               
          
                
          
    
          ),
        ),
      )
    );
  }
}