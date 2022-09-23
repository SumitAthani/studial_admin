import 'package:flutter/material.dart';
import 'package:studial_admin/utils/utils.dart';

import '../api/api_routes.dart';
import '../api/utils.dart';

class Approved extends StatefulWidget {
  const Approved({Key? key}) : super(key: key);

  @override
  State<Approved> createState() => _ApprovedState();
}

class _ApprovedState extends State<Approved> {
  List approvedData = [];

  getApproved() async {
    var res = await Http.get(ApiRoutes.getApproved, authenticated: true);
    print(res["data"]);
    if (mounted) {
      setState(() {
        approvedData = res["data"];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApproved();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(milliseconds: 500), () {
            getApproved();
          });
        },
        child: Utils.buildList(approvedData));
  }
}
