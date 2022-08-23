import 'dart:convert' as json;

import 'package:auditdat/constants/app_constants.dart';
import 'package:auditdat/db/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final AuthService instance = AuthService._init();
  static late SharedPreferences prefs;

  AuthService._init();

  Future<Map<String, dynamic>> authenticate(
      String email, String password) async {
    print('${AppConstants.getEndpointUrl()}/api/auditdat/v1/authenticate');
    http.Response response = await http.post(
      Uri.parse(
          '${AppConstants.getEndpointUrl()}/api/auditdat/v1/authenticate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.jsonEncode(<String, String?>{
        'email': email,
        'password': password,
        // 'deviceToken': await FirebaseMessaging.instance.getToken(),
      }),
    );
    Map<String, dynamic> data = json.jsonDecode(response.body);
    return data;
  }

  Future login(User user, String token) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('user', json.jsonEncode(user.toJson()));
    prefs.setString('token', token);
  }

  Future<User?> getUser() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString('user') != null
        ? User.fromJson(json.jsonDecode(prefs.getString('user')!))
        : null;
  }

  Future<String?> getToken() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<bool?> logout() async {
    prefs = await SharedPreferences.getInstance();
    // await FirebaseMessaging.instance.deleteToken();

    return prefs.remove('user');
  }
}
