import 'package:flutter/material.dart';
import 'package:studial_admin/widgets/bottomNavigationBar.dart';


class CheckBar extends StatefulWidget {
  const CheckBar({Key? key}) : super(key: key);

  @override
  State<CheckBar> createState() => _CheckBarState();
}

class _CheckBarState extends State<CheckBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        bottomNavigationBar: MyBottomNavigationBar(setPage: (){},),
    );
  }
}
