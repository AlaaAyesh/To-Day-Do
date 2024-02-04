import 'package:flutter/material.dart';
// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
        required this.text,
        this.ontap,
        required this.color,
        required this.textcolor,
        this.iconImage});
  String? text;
  VoidCallback? ontap;
  Color? color;
  Color? textcolor;
  String? iconImage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            // color:color,
            gradient: LinearGradient(colors: [
              color!.withOpacity(0.5),
              color!,
            ]),
            boxShadow: [
              BoxShadow(
                color: color!.withOpacity(0.3),
                offset: const Offset(
                  0,
                  5.0,
                ),
                blurRadius: 2.0,
                spreadRadius: 2.0,
              ),
            ]),
        height: 55,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                text ?? '',
                style: TextStyle(fontSize: 18, color: textcolor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
