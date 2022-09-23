import 'package:flutter/material.dart';
import 'package:studial_admin/utils/utils.dart';

import '../api/api_routes.dart';
import '../api/utils.dart';

class ToBeApproved extends StatefulWidget {
  const ToBeApproved({Key? key}) : super(key: key);

  @override
  State<ToBeApproved> createState() => _ToBeApprovedState();
}

class _ToBeApprovedState extends State<ToBeApproved> {
  List toBeApprovedData = [];

  void getToBeApproved() async {
    var res = await Http.get(ApiRoutes.getNotApproved, authenticated: true);
    print(res["data"]);
    if (mounted) {
      setState(() {
        toBeApprovedData = res["data"];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToBeApproved();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(milliseconds: 500), () {
            getToBeApproved();
          });
        },
        child: Utils.buildList(toBeApprovedData));
  }
}
