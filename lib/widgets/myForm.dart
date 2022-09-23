import 'package:flutter/material.dart';

import 'inputBox.dart';
import 'myButton.dart';
import 'myBanner.dart';

class MyForm extends StatelessWidget {
  final String formTitle;
  final String? optionalText;
  final String? optionalFunctionalText;
  final Function? optionalFunctionOnTap;
  final GlobalKey formKey;
  final String buttonText;
  final Function buttonOnTap;
  final List<TextEditingController> controllers;
  final List<String>? labels;
  final List<Function> validators;

  // final GlobalKey<FormState> _key = GlobalKey<FormState>();

  const MyForm(
      {Key? key,
      required this.formTitle,
      this.optionalText,
      this.optionalFunctionalText,
      this.optionalFunctionOnTap,
      required this.formKey,
      required this.buttonText,
      required this.buttonOnTap,
      required this.controllers,
      this.labels, required this.validators})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
            ),
            MyBanner(
                text: formTitle,
                // color: Colors.orange[300],
                textColor: Colors.black87),
            if (optionalFunctionalText != null || optionalText != null) ...[
              MyBanner(
                child: Row(
                  children: [
                    if (optionalText != null)
                      Text(
                        optionalText!,
                        style: TextStyle(color: Color(0xff939296)),
                      ),
                    if (optionalFunctionalText != null)
                      InkWell(
                        onTap: () {
                          optionalFunctionOnTap!(
                              optionalFunctionalText?.toLowerCase());
                        },
                        child: Text(
                          optionalFunctionalText!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                  ],
                ),
              )
            ],
            // loginForm(),
            Form(
              key: formKey,
              child: Column(
                children: [
                  for (int i = 0; i < controllers.length; i++)
                    InputBox(
                      controller: controllers[i],
                      backGroundColor: Colors.black12,
                      onFocusBackgroundColor: const Color(0xfffece84),
                      hintText: labels != null ? labels![i] : null,
                      validator: validators[i],
                    ),
                  MyButton(
                    text: buttonText,
                    onTap: () {
                      buttonOnTap();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
