import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final login;
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
