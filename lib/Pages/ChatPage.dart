// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/Components/ChatBubble.dart';
import 'package:chat_app/Components/MyTextField.dart';
import 'package:chat_app/Services/Chat/ChatService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {

  final String receiveruserEmail;
  final String receiverUserId;

  const ChatPage({
    Key? key,
    required this.receiveruserEmail,
    required this.receiverUserId,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void SendMessage() async {

  if (_messageController.text.isNotEmpty) {

  await _chatService.SendMessage(widget.receiverUserId, _messageController.text);

  _messageController.clear();

  }

  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.grey.shade200,
    appBar: AppBar(
    backgroundColor: Colors.orange,
    title: Text("${widget.receiveruserEmail}"),
    centerTitle: true,
    ),
    body: Column(children: [

    Expanded(child: _buildMessageList()),

    _buildMessageInput(),
    SizedBox(height: 24,),

    ],),
    );
    }

  Widget _buildMessageList() {

  return StreamBuilder(
  stream: _chatService.getMessages(widget.receiverUserId, _firebaseAuth.currentUser!.uid),
  builder: (context,snapshot) {

  if (snapshot.hasError) {

  return Text("Error ${snapshot.error}");

  }

  if (snapshot.connectionState == ConnectionState.waiting) {

  return Text("Loading...");

  }

  return ListView(
  children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
  );
  });
  }

  Widget _buildMessageItem(DocumentSnapshot document) {

  Map<String,dynamic> data = document.data() as Map<String,dynamic>;

  // align the messages to the right if the sender is the current user otherwise to the left
  var alignment = (data["senderId"] == _firebaseAuth.currentUser!.uid) ? Alignment.centerRight : Alignment.centerLeft;
  
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
    alignment: alignment,
    child: Column(
    crossAxisAlignment: (data["senderId"] == _firebaseAuth.currentUser!.uid) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    mainAxisAlignment: (data["senderId"] == _firebaseAuth.currentUser!.uid) ? MainAxisAlignment.end : MainAxisAlignment.start,
    children: [
  
    Text(data["senderEmail"]),
    SizedBox(height: 6,),
    ChatBubble(message: data["message"])
  
    ],),
    ),
  );
  }

  Widget _buildMessageInput() {

  return Row(children: [

  Expanded(child: MyTextField(hintText: "Email", obscureText: false, controller: _messageController)),

  IconButton(onPressed: SendMessage, icon: Icon(Icons.send,color: Colors.orange,))

  ],);
  }
  }