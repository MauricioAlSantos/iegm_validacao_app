import 'package:flutter/material.dart';
import 'package:iegm_validacao_app/selecao_equipe.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login_page';
  @override
  _LoginPageState createState()=> new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String login;//matricula
  String password;
  @override
  Widget build(BuildContext context) {
    Widget logo = new Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 80,
        child: Image.asset('assets/iegm_icon_2019.png')
      ),
    );

    Widget login = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Login',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: 'some password',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(SelecaoEquipe.tag);
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        children: <Widget>[
        logo,
        SizedBox(height: 48.0),
        login,
        SizedBox(height: 24.0),
        password,
        SizedBox(height: 24.0),
        loginButton,
        forgotLabel]
        )
      ),
    );
  }
}

