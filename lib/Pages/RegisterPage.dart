// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/Services/Auth/AuthService.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/Components/MyButton.dart';
import 'package:chat_app/Components/MyTextField.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {

  void Function()? onTap;

  RegisterPage({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  final CPController = TextEditingController();

  @override
  Widget build(BuildContext context) {

  void SignUp() async {

  if (PasswordController.text == CPController.text) {

  try {

  final _auth = Provider.of<AuthService>(context,listen: false);

  await _auth.SignUp(EmailController.text, PasswordController.text);

  } catch (e) {

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));

  }


  } else {

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password and Confirm Passsword Do Not Match")));

  }

  }
  
    return Scaffold(
    backgroundColor: Colors.grey.shade200,
    body: SingleChildScrollView(child: SafeArea(
    child: Column(children: [
    SizedBox(height: 64,),
    // Logo
    Center(child: Icon(Icons.message,size: 100,color: Colors.orange,),),
    SizedBox(height: 24,),
    
    // Welcome Back Message
    Text("Welcome Back, You've Been Missed",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
    
    SizedBox(height: 24,),
    // email textfield
    MyTextField(hintText: "Email", obscureText: false, controller: EmailController),
    SizedBox(height: 36,),
    
    // password textfield
    MyTextField(hintText: "Password", obscureText: true, controller: PasswordController),
    SizedBox(height: 42,),
    MyTextField(hintText: "Confirm Password", obscureText: true, controller: CPController),
    SizedBox(height: 42,),
    
    // Sign In Button
    MyButton(onTap: SignUp, text: "Sign Up"),
    SizedBox(height: 42,),
    
    // not a member? register now
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

    Text("Already member?   "),
    GestureDetector(onTap: onTap,child: Text("Log-In",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange),),)

    ],
    )
    
    ],))),

    );
  }
}