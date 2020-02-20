import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResponseLogin {
  final String email;
  final String name;
  final String id;

  ResponseLogin({this.id, this.email, this.name});
  factory ResponseLogin.createPost(Map<String, dynamic> json) {
    return ResponseLogin(
      id: json['user']['_id'],
      name: json['user']['name'],
      email: json['user']['email'],
    );
  }

  static Future login(String email, String password) async {
    var _api= DotEnv().env['API'];
    var url = '$_api'+'users/login';

    var data = {"email": email, "password": password};

    try {
      var response = await http.post(
        url,
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.statusCode);
      return response.statusCode == 200
          ? ResponseLogin.createPost(json.decode(response.body))
          : null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
