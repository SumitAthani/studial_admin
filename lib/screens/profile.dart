import 'package:flutter/material.dart';
import 'package:studial_admin/api/api_routes.dart';
import 'package:studial_admin/api/utils.dart';
import 'package:studial_admin/constants/myColors.dart';
import 'package:studial_admin/navigation/appRoutes.dart';
import 'package:studial_admin/utils/token.dart';
import 'package:studial_admin/widgets/card.dart';
import 'package:studial_admin/widgets/myButton.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "", email = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileDetails();
  }

  Future<void> getProfileDetails() async {
    var user = await Http.get(ApiRoutes.getProfile, authenticated: true);
    if (mounted) {
      setState(() {
        name = user["data"]["name"];
        email = user["data"]["email"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          profileBox("Name", name),
          profileBox("Email", email),
          MyButton(
              text: "LOGOUT",
              onTap: () async {
                await Token.delete();
                Navigator.popAndPushNamed(context, AppRoutes.login);
                print("logged out");
              }),
          SizedBox(height: 150,),
          Image.asset(
            "assets/logo.png",
            width: 250,
            height: 250,
          )
        ],
      ),
      padding: EdgeInsets.only(bottom: 100),
    );
  }
}

Widget profileBox(fieldName, value) {
  return Row(
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: MyColors.ternaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Text(fieldName + ": " + value, style: TextStyle(fontSize: 18)),
        ),
      ),
    ],
  );
}
