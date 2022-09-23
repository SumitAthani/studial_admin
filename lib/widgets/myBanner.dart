import 'package:flutter/material.dart';

class MyBanner extends StatelessWidget {
  final String? text;
  final Widget? child;
  final Color? color;
  final Color? textColor;

  const MyBanner(
      {Key? key,
      this.text,
      this.color = Colors.white,
      this.textColor = Colors.black,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: child != null
                ? child
                : Text(
                    text!,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
