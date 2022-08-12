import 'package:flutter/material.dart';

import '../constant/coloers.dart';

class CostumTextField extends StatelessWidget {
  final String hentText;
  final String lableText;
  final TextEditingController controller;
  bool obscureText;
  bool isPassowred;
  bool isPhoneNumber;
  Function? suffixIconFunction;

  CostumTextField(
      {required this.hentText,
      required this.lableText,
      required this.controller,
      this.obscureText = false,
      this.suffixIconFunction,
      this.isPassowred = false,
      this.isPhoneNumber = false});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: (value) {
        if (value == null) {
          return "Please enter a valied email";
        }
      },
      controller: controller,
      keyboardType: isPhoneNumber == false
          ? TextInputType.emailAddress
          : TextInputType.phone,
      decoration: InputDecoration(
        suffixIcon: isPassowred == false
            ? null
            : IconButton(
                onPressed: () => suffixIconFunction!(),
                icon: Icon(Icons.remove_red_eye_rounded)),
        hintText: hentText,
        contentPadding: EdgeInsets.all(23),
        hintStyle: TextStyle(fontWeight: FontWeight.bold),
        labelText: lableText,
        labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 4, color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 4, color: ConstanColoers.primary300),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 4),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 4),
        ),
      ),
    );
  }
}
