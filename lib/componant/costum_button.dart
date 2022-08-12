import 'package:chat_application/constant/coloers.dart';
import 'package:flutter/material.dart';

class CostumButton extends StatelessWidget {
  CostumButton({
    required this.color,
    required this.title,
    required this.onPressed,
  });
  final Color color;
  final String title;

  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
        child: Text(
          textAlign: TextAlign.center,
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
