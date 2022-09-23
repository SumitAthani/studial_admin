import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studial_admin/api/api_routes.dart';
import 'package:studial_admin/api/utils.dart';
import 'package:studial_admin/widgets/card.dart';
import 'package:open_file/open_file.dart';

import '../widgets/MyDialogBox.dart';

class Utils {
  static Widget buildList(List list) {
    return ListView.builder(
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        itemCount: list.length,
        cacheExtent: 1000,
        itemBuilder: (BuildContext context, int index) {
          final data = list[index];

          String extension = data["fileName"].toString().split(".").last;

          print(extension);

          String imageFolderPath = "assets/documenticons";

          String imagePath = "$imageFolderPath/pdf.png";

          if (extension == 'doc' || extension == 'docx') {
            imagePath = "$imageFolderPath/doc.png";
          } else if (extension == 'ppt' || extension == 'pptx') {
            imagePath = "$imageFolderPath/ppt.png";
          } else if (extension == 'xls' ||
              extension == 'xlsx' ||
              extension == 'xlsm' ||
              extension == "xlsb") {
            imagePath = "$imageFolderPath/xls.png";
          } else if (extension == 'png' ||
              extension == 'jpeg' ||
              extension == 'jpg' ||
              extension == 'webp') {
            imagePath = "$imageFolderPath/image.png";
          } else if (extension == "pdf") {
            imagePath = "$imageFolderPath/pdf.png";
          } else {
            imagePath = "$imageFolderPath/unknown.png";
          }

          return MyCard(
            key: Key(data["_id"]),
            fileId: data["_id"],
            fileName: data["fileName"],
            title: data["title"],
            semester: data["semester"],
            subject: data["subject"],
            type: data["type"],
            userId: data["userId"],
            image: imagePath,
          );
        });
  }

  static Future<String> createFileFromString(
      String base64String, String fileName) async {
    final encodedStr = base64String;
    Uint8List bytes = base64.decode(encodedStr);
    String path = (await getTemporaryDirectory()).path;
    print(path);
    final dir = Directory(path);
    File file = File("$path/$fileName");
    if (await dir.exists()) {
      print(dir);
      // File file = File("$dir/$fileName");
      await file.writeAsBytes(bytes);
      // await file.open();

    } else {
      dir.create();
      // File file = File("$dir/$fileName");
      await file.writeAsBytes(bytes);
      // retun file.path;

    }
    print(file.path);
    // await file.open();
    var res = await OpenFile.open(file.path);
    print(res.message);
    return file.path;
  }

  static openFile(String path) async {
    var externalStorage = (await getTemporaryDirectory()).path;

    var res = await OpenFile.open("$externalStorage/$path");
    if (res.message != "done") {
      return false;
    } else {
      return true;
    }
    // return file.path;
  }

  static deleteFile(String path) async {
    var file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  static checkFile(path) async {
    String externalStoragePath = (await getTemporaryDirectory()).path;

    var dir = File("$externalStoragePath/$path");
    print("path");
    print(dir.path);
    if (await dir.exists()) {
      return true;
    } else {
      return false;
    }
  }

  static checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
  }

  static displayDialog(context) {
    myDialogBox("Connection Lost", "Connect to the internet", context);
  }
}
