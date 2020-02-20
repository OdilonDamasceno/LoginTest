import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loginapp/pages/home/home.page.dart';
import 'package:loginapp/pages/login/login.page.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Api',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.from(
          colorScheme: ColorScheme.dark(
        primary: Colors.purple[600],
        secondary: Colors.purple[600],
        primaryVariant: Colors.purple[600],
        secondaryVariant: Colors.purple[600],
        surface: Colors.purple,
      )),
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
          primary: Colors.purple[600],
          secondary: Colors.purple,
          primaryVariant: Colors.purple,
          secondaryVariant: Colors.purple,
          surface: Colors.purple,
        ),
      ),
      routes: {
        '/': (context) => Login(),
        '/home': (context) => Home(),
      },
    );
  }
}
