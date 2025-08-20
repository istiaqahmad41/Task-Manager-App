import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_now/components/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback OnSave;
  VoidCallback OnCancel;
  DialogBox(
      {super.key,
      required this.controller,
      required this.OnSave,
      required this.OnCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Add a new task"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: "save", OnPressed: OnSave),
                SizedBox(
                  width: 5,
                ),
                MyButton(text: "cancel", OnPressed: OnCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
