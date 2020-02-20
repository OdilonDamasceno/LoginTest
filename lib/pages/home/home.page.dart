import 'package:flutter/material.dart';
import 'package:loginapp/pages/login/auth.reg.dart';

class Home extends StatelessWidget {
  final ResponseLogin login;
  Home({this.login});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Olá ' + login.name),
      ),
    );
  }
}
