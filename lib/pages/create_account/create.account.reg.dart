import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateAcc {
  final String email;
  final String name;
  final String password;
  final String id;
  CreateAcc({this.password, this.email, this.name, this.id});
  factory CreateAcc.createPost(Map<String, dynamic> json) {
    return CreateAcc(
      name: json['user']['name'],
      email: json['user']['email'],
      id: json['user']['_id'],
    );
  }

  static Future create(String email, String password, String name) async {
    var _api = DotEnv().env['API'];
    var url = '$_api' + 'users';
    var data = {"email": email, "password": password, "name": name};

    try {
      var response = await http.post(
        url,
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.statusCode);
      //print(response.body);
      return (response.statusCode == 200) || (response.statusCode == 201)
          ? CreateAcc.createPost(json.decode(response.body))
          : null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
