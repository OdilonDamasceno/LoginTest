import 'package:flutter/material.dart';
import 'package:loginapp/pages/create_account/create.account.dart';
import 'package:loginapp/pages/home/home.page.dart';
import 'package:loginapp/pages/login/auth.reg.dart';
import 'package:loginapp/widgets/rich.text.dart';
import 'package:loginapp/widgets/size.conf.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ResponseLogin _login;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double pixel = SizeConfig.orientation == Orientation.landscape
        ? SizeConfig.blockSizeHorizontal / SizeConfig.blockSizeVertical
        : SizeConfig.blockSizeVertical / SizeConfig.blockSizeHorizontal;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.only(
            top: pixel * 90,
            left: pixel * 10,
            right: pixel * 10,
          ),
          children: <Widget>[
            Wrap(
              runSpacing: pixel * 10,
              children: <Widget>[
                Center(
                  child: Container(
                    width: pixel * 50,
                    height: pixel * 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(pixel * 50),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Icon(
                      Icons.vpn_key,
                      size: pixel * 25,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  controller: emailController,
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: passwordController,
                  validator: validatePassword,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: CustomRichText(
                    simpleText: 'Esqueceu sua senha? ',
                    presText: 'Recupere',
                    pressStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            body: Center(
                              child: Text('Não posso fazer nada :('),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: FloatingActionButton(
                    elevation: 1,
                    onPressed: () async {
                      var response = await _validateInputs();

                      response != null
                          ? _logged(context)
                          : _showDialog(context);
                    },
                    isExtended: true,
                    child: Text(
                      'Entrar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomRichText(
                      simpleText: 'Não tem uma conta? ',
                      presText: 'Crie uma',
                      pressStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateAccount(),
                          ),
                        );
                      }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showDialog(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Credenciais inválidas'),
        actions: <Widget>[
          FlatButton(
            child: Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _logged(context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Home(
          login: _login,
        ),
      ),
      ModalRoute.withName('/home'),
    );
  }

  _validateInputs() async {
    var response;
    if (_formKey.currentState.validate()) {
      response = await ResponseLogin.login(
        emailController.text,
        passwordController.text,
      );

      response != null ? _login = response : _login = null;
      return response;
    } else {
      return response;
    }
  }
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (value.length == 0)
    return 'Insert a email';
  else if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}

String validatePassword(value) {
  if (value.length < 4) {
    return 'Enter a valid password';
  } else {
    return null;
  }
}
