import "package:flutter/material.dart";

myDialogBox(title, description, context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title.toString()),
      content: description.runtimeType == String
          ? Text(description.toString())
          : description,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'OK');
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
