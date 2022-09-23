import 'package:flutter/material.dart';
import 'package:studial_admin/api/api_routes.dart';
import 'package:studial_admin/api/utils.dart';
import 'package:studial_admin/constants/myColors.dart';
import 'package:studial_admin/screens/approved.dart';
import 'package:studial_admin/screens/profile.dart';
import 'package:studial_admin/screens/toBeApproved.dart';
import 'package:studial_admin/widgets/bottomNavigationBar.dart';
import 'package:studial_admin/widgets/card.dart';

// import 'package:studial_admin/widgets/profile.dart';
import 'package:permission_handler/permission_handler.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  // States

  getStoragePermission() async {
    PermissionStatus permissionResult = await Permission.storage.request();
    print(permissionResult);
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getStoragePermission();
  }

  //Page State
  Widget page = const ToBeApproved();

  List<Widget> pages = [
    const Approved(),
    const Profile(),
    const ToBeApproved(),
  ];

  setPage(int num) {
    print(num);
    setState(() {
      page = pages[num];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyColors.secondaryColor,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            // color: Colors.red,
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  // margin: EdgeInsets.only(bottom: 200),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height / 10,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, MediaQuery.of(context).size.height / 15,),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.85),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: page,
                ),
              ],
            ),
          ),
          MyBottomNavigationBar(setPage: setPage),
        ],
      ),
    );
  }
}
