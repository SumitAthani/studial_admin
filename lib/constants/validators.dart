import 'package:studial_admin/constants/validation.dart';

class Validators {
  static emailValidator(String value) {
    //Username Validator
    if (value.isEmpty) {
      return "*required";
    } else if (!RegExp(Validation.emailRegex).hasMatch(value.trim())) {
      return "Provide a valid email";
    } else {
      return null;
    }
  }

  static passwordValidator(String value) {
    //Password Validator
    if (value.isEmpty) {
      return "*required";
    } else if (value.length < 8) {
      return "minimum length of 8 required";
    } else {
      return null;
    }
  }

  static stringValidator(String value) {
    if (value.isEmpty) {
      return "*required";
    }
  }
}
