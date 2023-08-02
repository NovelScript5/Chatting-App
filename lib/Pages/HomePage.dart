import 'package:chat_app/Pages/ChatPage.dart';
import 'package:chat_app/Services/Auth/AuthService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void SignOut() {

  final firebaseauth = Provider.of<AuthService>(context,listen: false);

  firebaseauth.SignOut();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    appBar: AppBar(
    backgroundColor: Colors.grey.shade200,
    title: Text(_auth.currentUser!.email.toString(),style: TextStyle(color: Colors.black),),
    centerTitle: true,
    actions: [IconButton(onPressed: SignOut, icon: Icon(Icons.outbond,size: 38,color: Colors.orange,))],
    ),
    body: _buildUserList(),
    );
  }

  Widget _buildUserList() {

  return StreamBuilder(
  stream: FirebaseFirestore.instance.collection("People").snapshots(),
  builder: (context,snapshot) {

  if (snapshot.hasError) {

  return Text("Error ${snapshot.error}");

  } 

  if (snapshot.connectionState == ConnectionState.waiting) {

  return Text("Loading...");

  }

  return ListView(
  
  children: snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc)).toList(),

  );
  });
  }

  Widget _buildUserListItem(DocumentSnapshot document) {

  Map<String,dynamic> data = document.data()! as Map<String,dynamic>;

  if (_auth.currentUser!.email != data["email"]) {

  return ListTile(
  shape: BeveledRectangleBorder(side: BorderSide(width: 0.1)),
  leading: Icon(Icons.person,color: Colors.orange,),
  title: Text(data["email"]),
  onTap: () {

  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(receiveruserEmail: data["email"], receiverUserId: data["uid"])));

  },
  );

  } else {

  return Container();

  }

  }

  }