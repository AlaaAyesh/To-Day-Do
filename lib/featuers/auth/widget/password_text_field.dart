// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  PasswordTextField({
    super.key,
    this.hinttext,
    this.onchange,
    this.prefixIcon,
    this.suffixIconFirst,
    this.suffixIconSecond,
    required this.textType,
    this.onFieldSubmitted,
    this.onSaved,
  });
  String? hinttext;
  IconData? prefixIcon;
  IconData? suffixIconFirst;
  IconData? suffixIconSecond;
  TextInputType? textType;
  ValueChanged<String>? onFieldSubmitted;
  FormFieldSetter<String>? onSaved;

  Function(String)? onchange;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      onSaved: widget.onSaved,
      onFieldSubmitted: widget.onFieldSubmitted,
      keyboardType: widget.textType,
      validator: (value) {
        if (value == null) return 'required';
        return null;
      },
      onChanged: widget.onchange,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.prefixIcon),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
              _obscureText ? widget.suffixIconFirst : widget.suffixIconSecond),
        ),
        hintText: widget.hinttext,
        hintStyle: const TextStyle(color: Colors.grey),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }
}
