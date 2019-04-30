import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iegm_validacao_app/login_page.dart';
import 'package:iegm_validacao_app/home_page.dart';
import 'package:iegm_validacao_app/selecao_equipe.dart';

void main() => SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(new MyApp());
    });

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(rota: null),
    SelecaoEquipe.tag: (context) => SelecaoEquipe()
  };
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IEGM V',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(brightness: Brightness.dark,background: Color.fromRGBO(95, 126, 166, 1)),
        primaryColor: Color.fromRGBO(251, 251, 251, 1),
        iconTheme: IconThemeData(color: Colors.white,),
        primarySwatch: Colors.blueGrey,
        fontFamily: 'OpenSans',
        accentColor: Color.fromRGBO(96, 126, 166, 1),
        buttonColor: Color.fromRGBO(96, 126, 166, 1),
        buttonTheme: ButtonThemeData(buttonColor: Color.fromRGBO(251, 251, 251, 1),),
        backgroundColor: Color.fromRGBO(96, 126, 166, 1),
        scaffoldBackgroundColor: Color.fromRGBO(242, 242, 242, 1),
        textTheme: TextTheme(body1: TextStyle(fontSize: 18),subhead: TextStyle(fontSize: 18),
          subtitle: TextStyle(fontSize: 18),overline: TextStyle(fontSize: 12),body2: TextStyle(fontSize: 18),
          button: TextStyle(color: Colors.white70,)
        ),
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}