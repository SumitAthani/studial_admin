import 'package:studial_admin/api/api_url.dart';

class ApiRoutes {
  static const String login = "${ApiUrl.api}/login";
  static const String register = "${ApiUrl.api}/register";
  static const String getApproved = "${ApiUrl.api}/getApprovedFiles";
  static const String getNotApproved = "${ApiUrl.api}/getNotApprovedFiles";
  static const String getFile = "${ApiUrl.api}/getFile";
  static const String disApproveFile = "${ApiUrl.api}/delete";
  static const String approveFile = "${ApiUrl.api}/approve";
  static const String getUser = "${ApiUrl.api}/getUser";
  static const String getProfile = "${ApiUrl.api}/profile";
}
