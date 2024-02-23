// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';

class Custom_Widgets {

  static custom_textField (TextEditingController controller,
  String text){
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,vertical: 20
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          prefixIcon: const Icon(Icons.edit),
          border: const UnderlineInputBorder(),
          filled: true,
          fillColor: Colors.grey.shade800
         ),
      ),
    );
  }

  static custom_button(String text, void Function()? onPressed){
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(300, 50)
      ), child: Text(text),
    );
  }
}