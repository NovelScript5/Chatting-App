import 'package:chat_app/Pages/RegisterPage.dart';
import 'package:chat_app/Services/Auth/AuthGate.dart';
import 'package:chat_app/Services/Auth/AuthService.dart';
import 'package:chat_app/Services/Auth/LoginorRegister.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Pages/LoginPage.dart';

void main() async {
  
WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

runApp(ChangeNotifierProvider(create: (context) => AuthService(),
child: MyApp(),
));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(

    debugShowCheckedModeBanner: false,
    home: AuthGate(),

    );
  }
}