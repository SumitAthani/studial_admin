import 'package:flutter/material.dart';
import 'package:studial_admin/navigation/appRoutes.dart';
import 'package:studial_admin/screens/loginRegister.dart';
import 'package:studial_admin/screens/splash.dart';

// import 'package:studial_admin/screens/approved.dart';
import 'package:studial_admin/screens/myScreen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:studial_admin/utils/utils.dart';

void main() {
  runApp(MaterialApp(home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  bool alerted = false, connected = true;

  connectionStatus() async {
    if (await Utils.checkInternet() == false) {
      Utils.displayDialog(context);
    }

    var subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      // Got a new connectivity status!
      var connectivityResult = await (Connectivity().checkConnectivity());
      print(connectivityResult);
      if (connectivityResult == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
        print("conneceted to mobile");
      } else if (connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
        print("conneceted to Wifi");
      } else if (connectivityResult == ConnectivityResult.none) {
        // I am connected to a wifi network.
        print("lost internet connection");
        // if (!connected && !alerted) {
        Utils.displayDialog(context);
      }
    });
  }

  @override
  initState() {
    super.initState();

    connectionStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light, primarySwatch: Colors.amber),
        // home: Scaffold(
        //   floatingActionButton: FloatingActionButton(
        //     onPressed: () {},
        //   ),
        // ),
        home: const SplashScreen(),
        routes: {
          AppRoutes.login: (context) => Login(),
          AppRoutes.home: (context) => MyScreen()
        });
  }
}
