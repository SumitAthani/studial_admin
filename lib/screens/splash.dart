import 'package:flutter/material.dart';
import 'package:studial_admin/constants/myColors.dart';

import 'package:studial_admin/navigation/appRoutes.dart';
import 'package:studial_admin/utils/token.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // color = Colors.amber;
    // setState(() {});
    getToken();
  }

  getToken() async {
    var res = await Token.get();
    if (res == null) {
      print("bya");
      setState(() {
        color = MyColors.red;
      });
    } else {
      setState(() {
        color = MyColors.secondaryColor;
      });
    }
  }

  Color? color = MyColors.ternaryColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedContainer(
        duration: const Duration(seconds: 2),
        onEnd: () {
          if (color == MyColors.red) {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          } else {
            print(color);
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          }
        },
        color: color,
        child: SizedBox(
          // color: color,
          height: 400,
          width: 400,
        ),
      ),
    );
  }
}
