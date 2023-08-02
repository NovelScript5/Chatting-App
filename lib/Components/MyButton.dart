// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  void Function()? onTap;
  final String text;

  MyButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,child: 
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
    color: Colors.orange,
    borderRadius: BorderRadius.circular(12)
    ),
    child: Center(child: Text(text,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),),
    ),
    ),);
  }
}
