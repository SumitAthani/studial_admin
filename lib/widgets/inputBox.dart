import 'package:flutter/material.dart';

class InputBox extends StatefulWidget {
  final Color? backGroundColor;
  final Color? onFocusBackgroundColor;
  final String? hintText;
  final TextEditingController controller;
  final Function validator;

  const InputBox(
      {Key? key,
      this.backGroundColor,
      this.onFocusBackgroundColor,
      required this.controller,
      this.hintText,
      required this.validator})
      : super(key: key);

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  Color? color = Colors.black12;

  changeColor(backgroundColor) {
    print("changing state");
    setState(() {
      color = backgroundColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: TextFormField(
        keyboardType: (widget.hintText?.toLowerCase() == "email")
            ? TextInputType.emailAddress
            : TextInputType.text,
        obscureText:
            (widget.hintText?.toLowerCase() == "password") ? true : false,
        validator: (value) {
          return widget.validator(value);
        },
        controller: widget.controller,
        style: TextStyle(fontSize: 22),
        onTap: () {
          changeColor(widget.onFocusBackgroundColor);
        },
        onEditingComplete: () {
          changeColor(widget.backGroundColor);
        },
        decoration: InputDecoration(
            errorStyle: TextStyle(),
            // label: Text("username"),
            hintText: widget.hintText,
            // fillColor: Colors.grey,
            border: InputBorder.none),
        maxLines: 1,
      ),
    );
  }
}
