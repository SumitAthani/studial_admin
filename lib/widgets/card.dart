import 'package:flutter/material.dart';
import 'package:studial_admin/api/api_routes.dart';
import 'package:studial_admin/api/utils.dart';
import 'package:studial_admin/constants/myColors.dart';
import 'package:studial_admin/utils/utils.dart';
import 'package:studial_admin/widgets/MyDialogBox.dart';
import 'package:studial_admin/widgets/myBanner.dart';

class MyCard extends StatefulWidget {
  final String fileName, fileId, title, subject, type, semester, userId, image;

  const MyCard(
      {Key? key,
      required this.fileName,
      required this.fileId,
      required this.title,
      required this.subject,
      required this.type,
      required this.semester,
      required this.userId,
      required this.image})
      : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  //card states
  bool loading = false;
  double _height = 10.0;
  bool _delete = false;
  bool _approve = false;
  Color? _color = Colors.transparent;
  Alignment _alignment = Alignment.bottomCenter;
  String imagePath = "";

  //user State
  String uploadedBy = "";
  String uploadedByEmail = "";

  //File State
  String filePath = "";
  bool downloaded = false;

  Widget loader() {
    return CircularProgressIndicator(
      color: Colors.white,
    );
  }

  getUserDetails() async {
    var res = await Http.post(ApiRoutes.getUser, {"id": widget.userId},
        authenticated: true);
    if (mounted) {
      setState(() {
        res = res["data"];
        uploadedBy = res["name"];
        uploadedByEmail = res["email"];
      });
    }
  }

  checkFileExists() async {
    final String saveFileName =
        "${widget.title}${widget.semester}${widget.title}${widget.userId}${widget.fileName}";
    print(saveFileName);
    var exists = await Utils.checkFile(saveFileName);
    if (exists) {
      setState(() {
        downloaded = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("inited");
    if (uploadedBy == "") getUserDetails();

    checkFileExists();
  }

  setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  downLoadFile() async {
    setLoading(true);
    var res = await Http.post(
      ApiRoutes.getFile,
      {"id": widget.fileId},
      authenticated: true,
    );
    print(res["data"]);

    final String saveFileName =
        "${widget.title}${widget.semester}${widget.title}${widget.userId}${widget.fileName}";

    var path = await Utils.createFileFromString(
        res["data"][0]["uploadData"], saveFileName);

    setLoading(false);
    setState(() {
      downloaded = true;
      filePath = path;
    });
  }

  disApproveFile() async {
    setLoading(true);
    var res = await Http.post(
      ApiRoutes.disApproveFile,
      {"id": widget.fileId},
      authenticated: true,
    );
    // print(res["data"]);

    // Utils.createFileFromString(res["data"][0]["uploadData"], widget.fileName);
    setLoading(false);

    setState(() {
      _delete = true;
    });

    Utils.deleteFile(filePath);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _color = MyColors.red;
        _alignment = Alignment.center;
      });
    });
  }

  setChange() {
    setState(() {
      _delete = true;
      _alignment = Alignment.center;
      _height = 30;
    });
  }

  approveFile() async {
    setLoading(true);
    var res = await Http.post(
      ApiRoutes.approveFile,
      {"id": widget.fileId},
      authenticated: true,
    );
    print(res);

    // Utils.createFileFromString(res["data"][0]["uploadData"], widget.fileName);
    setLoading(false);

    setState(() {
      _approve = true;
    });
    Utils.deleteFile(filePath);
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _color = MyColors.ternaryColor;
        _alignment = Alignment.center;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)]),
      margin: EdgeInsets.only(bottom: 15),
      child: MyBanner(
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.center,
                // fit: StackFit.expand,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          print("get file");
                          if (!downloaded) {
                            downLoadFile();
                          } else {
                            print(filePath);
                            var res = await Utils.openFile("${widget.title}${widget.semester}${widget.title}${widget.userId}${widget.fileName}");
                            if (res == false) {
                              myDialogBox(
                                  "Error opening file",
                                  "No supported app found for ${widget.fileName.split(".").last}",
                                  context);
                            }
                          }
                        },
                        child: Container(
                          // margin: EdgeInsets.only(right),
                          padding: EdgeInsets.all(30),

                          // width: MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width/2.5,
                          height: MediaQueryData.fromWindow(
                                      WidgetsBinding.instance.window)
                                  .size
                                  .height *
                              0.23,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: MyColors.secondaryColor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          child: Image.asset(
                            widget.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      cardFunctions(approveFile, disApproveFile)
                    ],
                  ),
                  if (!downloaded)
                    Positioned.fill(
                      child: InkWell(
                        onTap: () {
                          downLoadFile();
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white70,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          clipBehavior: Clip.hardEdge,
                          child: Center(
                            child: Icon(
                              Icons.download_for_offline,
                              color: Colors.black54,
                              size: 75,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (loading)
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white38,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        clipBehavior: Clip.hardEdge,
                        child: Center(
                          child: loader(),
                        ),
                      ),
                    ),
                  if (_approve)
                    animationCover(_color, _height, _alignment,
                        Icons.check_circle, Colors.white),
                  if (_delete)
                    animationCover(
                        _color, _height, _alignment, Icons.delete, Colors.white)
                ],
              ),
            ),
            SizedBox(
              width: 7,
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    fieldData("Title", widget.title),
                    fieldData("Type", widget.type),
                    fieldData("Semester", widget.semester),
                    fieldData("Subject", widget.subject),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => MyColors.ternaryColor)),
                      onPressed: () {
                        myDialogBox(
                            "File Info",
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                fieldData("File", widget.fileName),
                                fieldData("By", uploadedBy),
                                fieldData("Email", uploadedByEmail),
                              ],
                            ),
                            context);
                      },
                      icon: Icon(Icons.info_outline_rounded),
                      label: Text("more info"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget fieldData(fieldName, fieldValue) {
  return Container(
    // alignment: Alignment.center,
    decoration: BoxDecoration(
        color: MyColors.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(5))),
    margin: EdgeInsets.fromLTRB(0, 2, 0, 2),
    padding: EdgeInsets.all(2),
    child: Text(
      fieldName + ": " + fieldValue,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 17,
        height: 1.2,
      ),
      softWrap: true,
      maxLines: 2,
      overflow: TextOverflow.fade,
    ),
  );
}

Widget cardFunctions(approveFile, disApproveFile) {
  return Material(
    borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
    clipBehavior: Clip.hardEdge,
    child: Ink(
      decoration: BoxDecoration(
          color: Color(0xfff56a4d),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                approveFile();
                // changePage(0);
              },
              child: Container(
                child: Center(
                  child: Icon(
                    Icons.done_outline,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                disApproveFile();
                // changePage(1);
              },
              child: Container(
                child: Center(
                  child: Icon(
                    Icons.delete_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget animationCover(color, height, alignment, IconData? icon, iconColor) {
  return Positioned.fill(
    child: AnimatedContainer(
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      curve: Curves.elasticOut,
      height: height,
      duration: const Duration(seconds: 1),
      alignment: alignment,
      child: Icon(
        icon,
        size: 50,
        color: iconColor,
      ),
    ),
  );
}
