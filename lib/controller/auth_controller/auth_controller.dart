import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezda/api/api_key.dart';
import 'package:tezda/model/user_model/user_model.dart';


class AuthController {
  final client = http.Client();

  Future<UserModel?> login(String username, String password) async {
    final Map<String, dynamic> body = {
      'username': username,
      'password': password,
    };
    try {
      final response =
          await client.post(Uri.parse("${API().baseUrl}${API().authUrl}"),
              headers: {'Content-Type': 'application/json',},
              body: jsonEncode(body));

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final UserModel user = UserModel.fromJson(result);
        SharedPreferences _pref = await SharedPreferences.getInstance();
        _pref.setString('token', user.token.toString());
        return user;

      } 
              
    } catch (e) {
    print(e);
    }
    return null;
  }
    // Check if the user is already logged in
  Future<bool> isLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    return token != null;
  }


}
