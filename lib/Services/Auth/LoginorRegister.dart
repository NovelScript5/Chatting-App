import 'package:chat_app/Pages/LoginPage.dart';
import 'package:chat_app/Pages/RegisterPage.dart';
import 'package:flutter/material.dart';

class LoginorRegister extends StatefulWidget {
  const LoginorRegister({super.key});

  @override
  State<LoginorRegister> createState() => _LoginorRegisterState();
}

class _LoginorRegisterState extends State<LoginorRegister> {

  bool IsLogin = false;

  void TogglePages() {

  setState(() {
    
  IsLogin = !IsLogin;

  });

  }

  @override
  Widget build(BuildContext context) {
    
  if (IsLogin) {

  return LoginPage(onTap: TogglePages);

  } else {

  return RegisterPage(onTap: TogglePages);

  }

  }
}