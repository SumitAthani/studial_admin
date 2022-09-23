import 'package:flutter/material.dart';
import 'package:studial_admin/constants/myColors.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final Function setPage;

  MyBottomNavigationBar({Key? key, required this.setPage}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  changeColor(num) {
    widget.setPage(num);
    for (int i = 0; i < 3; i++) {
      if (i == num) {
        if (i == 2) {
          iconData[i]["color"] = MyColors.secondaryColor;
        } else {
          setState(() {
            iconData[i]["color"] = MyColors.ternaryColor;
          });
        }
      } else {
        setState(() {
          iconData[i]["color"] = Colors.white;
        });
      }
    }
  }

  changePage(num) {
    changeColor(num);
    if (num == 0) {
    } else if (num == 1) {
    } else if (num == 2) {}
  }

  //States
  var iconData = [
    {"color": Colors.black},
    {"color": Colors.black},
    {"color": Colors.white}
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Material(
          child: Ink(
            color: MyColors.secondaryColor,
            height: MediaQuery.of(context).size.height / 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      changePage(0);
                    },
                    child: Center(
                      child: Icon(
                        Icons.done_all,
                        color: iconData[0]["color"],
                        size: 35,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      changePage(1);
                    },
                    child: Container(
                      child: Center(
                        child: Icon(
                          Icons.person,
                          color: iconData[1]["color"],
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          clipBehavior: Clip.hardEdge,
          height: 90,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(spreadRadius: 2, color: Colors.black26, blurRadius: 10)
          ], color: Colors.redAccent, shape: BoxShape.circle),
          child: Material(
            color: MyColors.ternaryColor,
            child: InkWell(
              splashColor: Colors.lightGreen,
              onTap: () {
                changePage(2);
              },
              child: Center(
                child: Icon(
                  Icons.pending,
                  color: iconData[2]["color"],
                  size: 50,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
