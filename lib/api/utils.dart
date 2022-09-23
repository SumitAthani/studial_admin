import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:studial_admin/utils/token.dart';

class Http {
  static post(url, data, {authenticated = false}) async {

    print("requesting");

    if (!authenticated) {
      var headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };

      var res = await http.post(Uri.parse(url),
          body: jsonEncode(data), headers: headers);
      return handleError(res);
    } else {
      var token = await Token.get();
      var headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };

      headers.addAll({"x-auth-token": token});
      var res = await http.post(Uri.parse(url),
          body: jsonEncode(data), headers: headers);

      print(res.body);
      return handleError(res);
    }
  }

  static get(url, {authenticated = false}) async {
    print("requesting");
    if (!authenticated) {
      var headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };

      var res = await http.get(Uri.parse(url), headers: headers);
      return handleError(res);
    } else {
      var token = await Token.get();
      var headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };

      headers.addAll({"x-auth-token": token});
      var res = await http.get(Uri.parse(url), headers: headers);

      // print(res.body);
      return handleError(res);
    }
  }

  static handleError(res) {
    if (res.statusCode >= 300 || res.statusCode < 200) {
      return false;
    } else {
      return jsonDecode(res.body);
    }
  }
}
