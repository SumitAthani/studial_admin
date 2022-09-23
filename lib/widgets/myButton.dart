import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  var color, text;

  var onTap;


  MyButton({Key? key, this.color = const Color(0xff8acac1), this.text = "text", this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: Material(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: color,
              child: InkWell(
                splashColor: Colors.orange,
                onTap: () {
                  onTap();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


}
