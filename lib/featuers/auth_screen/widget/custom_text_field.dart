import 'package:flutter/material.dart';
import 'package:to_day_do/core/global/colors/app_color.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  final bool isObsecure;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.data,
    required this.hintText,
    this.isObsecure = true,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Container(
      decoration:  BoxDecoration(
        color: isDarkMode?AppColors.mainColor4.withOpacity(0.75):Colors.white.withOpacity(0.25),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isObsecure,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            widget.data,
          ),
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
