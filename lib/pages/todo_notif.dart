import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoNotif extends StatelessWidget {
  const TodoNotif({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF2F5FF),
        body: Center(
            child: Text(
          "Developed by Istiaq Ahmad!",
          style: TextStyle(fontSize: 20),
        )));
  }
}
