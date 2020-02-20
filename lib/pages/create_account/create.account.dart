import 'package:flutter/material.dart';
import 'package:loginapp/pages/create_account/create.account.reg.dart';
import 'package:loginapp/widgets/size.conf.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  CreateAcc _create;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double pixel = SizeConfig.orientation == Orientation.landscape
        ? SizeConfig.blockSizeHorizontal / SizeConfig.blockSizeVertical
        : SizeConfig.blockSizeVertical / SizeConfig.blockSizeHorizontal;
    return Material(
      child: ListView(
        padding: EdgeInsets.only(
          top: pixel * 90,
          left: pixel * 10,
          right: pixel * 10,
        ),
        children: <Widget>[
          Form(
            key: _formKey,
            child: Wrap(
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
                      Icons.person_add,
                      size: pixel * 25,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome'),
                  controller: nameController,
                  validator: validateName,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: validateEmail,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  controller: passwordController,
                  validator: validatePassword,
                  obscureText: true,
                ),
                Container(
                  width: double.infinity,
                  child: FloatingActionButton(
                    elevation: 1,
                    onPressed: () async {
                      var response = await _validateInputs();
                      response != null
                          ? _created(context)
                          : _notCreated(context);
                      setState(() {
                        emailController.text = '';
                        passwordController.text = '';
                        nameController.text = '';
                      });
                    },
                    isExtended: true,
                    child: Text(
                      'Criar conta',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _notCreated(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('O usuário não pôde ser criado'),
        actions: <Widget>[
          FlatButton(
            child: Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _created(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Usuário criado com sucesso!'),
        actions: <Widget>[
          FlatButton(
            child: Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  _validateInputs() async {
    var response;
    if (_formKey.currentState.validate()) {
      response = await CreateAcc.create(
        emailController.text,
        passwordController.text,
        nameController.text,
      );

      response != null ? _create = response : _create = null;
      setState(() {});
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

String validateName(value) {
  Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(value)) {
    return 'Enter a valid Name';
  } else {
    return null;
  }
}
