import 'package:flutter/material.dart';
import 'package:studial_admin/api/api_routes.dart';
import 'package:studial_admin/api/utils.dart';
import 'package:studial_admin/constants/validators.dart';
import 'package:studial_admin/navigation/appRoutes.dart';
import 'package:studial_admin/utils/token.dart';
import 'package:studial_admin/widgets/MyDialogBox.dart';
import 'package:studial_admin/widgets/myForm.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // states
  Color? inputBoxColor = const Color(0xfffece84);

  var viewPage = "login";

  final loginPageValidators = [
    Validators.emailValidator,
    Validators.passwordValidator
  ];

  final registerPageValidators = [
    Validators.stringValidator,
    Validators.emailValidator,
    Validators.passwordValidator
  ];

  changePage(val) {
    if (val == "login") {
      setState(() {
        viewPage = "login";
      });
    } else {
      setState(() {
        viewPage = "register";
      });
    }
  }

  final loginFormDetails = {
    "title": "Hey, Login here",
    "buttonText": "Login",
    "buttonOnTap": () {
      print("Logged in");
    },
    "formKey": GlobalKey<FormState>(),
    "controllers": [TextEditingController(), TextEditingController()]
  };

  final loginFormControllers = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Stack(
            children: [
              Positioned(
                left: -100,
                top: -50,
                right: MediaQuery.of(context).size.width / 2.5,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.amber,
                  ),
                ),
              ),
              viewPage == "login"
                  ? MyForm(
                      optionalFunctionOnTap: changePage,
                      optionalText: LoginFormDetails.optionalText,
                      optionalFunctionalText:
                          LoginFormDetails.optionalFunctionalText,
                      formTitle: LoginFormDetails.title,
                      formKey: LoginFormDetails.formKey,
                      buttonText: "Login",
                      buttonOnTap: () async {
                        if (LoginFormDetails.formKey.currentState!.validate()) {
                          var body = await Http.post(ApiRoutes.login, {
                            "email": LoginFormDetails.controllers[0].text,
                            "password": LoginFormDetails.controllers[1].text
                          });
                          // print(body);
                          if (body == false) {
                            myDialogBox("Login Error",
                                "Email/Password Incorrect", context);
                          } else {
                            print(body["token"]);
                            await Token.save(body["token"]);
                            LoginFormDetails.formKey.currentState?.reset();
                            Navigator.popAndPushNamed(context, AppRoutes.home);
                          }
                        }

                        print(LoginFormDetails.controllers[0].text);
                        print(LoginFormDetails.controllers[1].text);
                        // LoginFormDetails.formKey.currentState!.validate();
                      },
                      labels: LoginFormDetails.labels,
                      controllers: LoginFormDetails.controllers,
                      validators: loginPageValidators,
                    )
                  : MyForm(
                      optionalFunctionOnTap: changePage,
                      optionalText: RegistrationFormDetails.optionalText,
                      optionalFunctionalText:
                          RegistrationFormDetails.optionalFunctionalText,
                      formTitle: RegistrationFormDetails.title,
                      formKey: RegistrationFormDetails.formKey,
                      buttonText: RegistrationFormDetails.buttonText,
                      buttonOnTap: () async {
                        if (RegistrationFormDetails.formKey.currentState!
                            .validate()) {
                          var body = await Http.post(ApiRoutes.register, {
                            "name": RegistrationFormDetails.controllers[0].text,
                            "email":
                                RegistrationFormDetails.controllers[1].text,
                            "password":
                                RegistrationFormDetails.controllers[2].text
                          });
                          // print(body);
                          if (body == false) {
                            myDialogBox("SignUp Error",
                                "An error occurred signing you up", context);
                          } else {
                            print(body["token"]);
                            await Token.save(body["token"]);
                            RegistrationFormDetails.formKey.currentState
                                ?.reset();
                            Navigator.popAndPushNamed(context, AppRoutes.home);
                          }
                        }
                      },
                      controllers: RegistrationFormDetails.controllers,
                      labels: RegistrationFormDetails.labels,
                      validators: registerPageValidators,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginFormDetails {
  static String title = "Hey, Login here";
  static String buttonText = "Login";

  static buttonOnTap() {
    print("Logged in");
  }

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController()
  ];
  static List<String> labels = ["Email", "Password"];

  static String optionalText = "Don't have one/ ";
  static String optionalFunctionalText = "Create Now";
}

class RegistrationFormDetails {
  static String title = "Hi, Register here";
  static String buttonText = "Register";

  static buttonOnTap() {
    formKey.currentState!.validate();
    print("Register this buton");
  }

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  static List<String> labels = ["Username", "Email", "Password"];

  static String optionalText = "if you already have/ ";
  static String optionalFunctionalText = "Login";
}

//
// Widget loginBox(changePage) {
//   return Scaffold(
//     backgroundColor: Colors.transparent,
//     body: SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 120,
//           ),
//           MyBanner(
//               text: "Hey Login",
//               color: Colors.orange[300],
//               textColor: Colors.black87),
//           MyBanner(
//             child: Row(
//               children: [
//                 Text(
//                   "If you are New/ ",
//                   style: TextStyle(color: Color(0xff939296)),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     changePage("register");
//                   },
//                   child: Text(
//                     "Create New",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           loginForm(),
//         ],
//       ),
//     ),
//   );
// }
//
// Widget registerBox(changePage) {
//   return Scaffold(
//     backgroundColor: Colors.transparent,
//     body: SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 120,
//           ),
//           MyBanner(
//               text: "Hey, Welcome to Studial Admin",
//               color: Colors.orange[300],
//               textColor: Colors.black87),
//           MyBanner(
//             child: Row(
//               children: [
//                 Text(
//                   "If you already have/ ",
//                   style: TextStyle(color: Color(0xff939296)),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     changePage("login");
//                   },
//                   child: Text(
//                     "Login",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           registerForm(),
//         ],
//       ),
//     ),
//   );
// }
//
// Widget loginForm() {
//   return Form(
//     child: Column(
//       children: [
//         InputBox(
//           backGroundColor: Colors.black12,
//           onFocusBackgroundColor: Color(0xfffece84),
//         ),
//         InputBox(
//           backGroundColor: Colors.black12,
//           onFocusBackgroundColor: Color(0xfffece84),
//         ),
//         MyButton(
//           text: "Login",
//           onTap: () {
//             print("logged in");
//           },
//         ),
//       ],
//     ),
//   );
// }
//
// Widget registerForm() {
//   return Form(
//     child: Column(
//       children: [
//         InputBox(
//           backGroundColor: Colors.black12,
//           onFocusBackgroundColor: Color(0xfffece84),
//         ),
//         InputBox(
//           backGroundColor: Colors.black12,
//           onFocusBackgroundColor: Color(0xfffece84),
//         ),
//         MyButton(
//           text: "Register",
//           onTap: () {
//             print("register in");
//           },
//         ),
//       ],
//     ),
//   );
// }
