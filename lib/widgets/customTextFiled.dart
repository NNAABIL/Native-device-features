import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final Function validator;
  final Function onSaved;

  CustomTextField({this.title, this.validator, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(labelText: title),
    );
  }
}
