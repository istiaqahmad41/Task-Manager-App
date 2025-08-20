import 'package:flutter/material.dart';

class NewButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isActive;

  const NewButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isActive ? onPressed : null,
      color: isActive ? Colors.blueAccent : Colors.grey.shade400,
      elevation: isActive ? 4 : 0,
      disabledColor: Colors.grey.shade400,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.grey.shade800,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
