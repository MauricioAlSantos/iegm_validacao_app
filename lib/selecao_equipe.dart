import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:iegm_validacao_app/iegm_classes.dart';
import 'package:iegm_validacao_app/home_page.dart';

class SelecaoEquipe extends StatelessWidget{
  static final String tag = 'selecao_equipe_page';

  final Future<List<Rota>> rotas = fetchRotas();

  @override
  Widget build(BuildContext context) {
    
    var result = FutureBuilder<List<Rota>>(
      future: rotas,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(child:criarLista(snapshot.data));
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Card(child:Text("Ocorreu um erro"));
        }
        // By default, show a loading spinner
        return CircularProgressIndicator();
      },
    );

    return Container(color: Theme.of(context).primaryColor,child:
      Container(margin: EdgeInsets.only(top:25) ,child:
        Column(mainAxisSize: MainAxisSize.max,children:[
          Container(height: 60,width:double.infinity,margin: EdgeInsets.only(top:0),child:
            Card(
          child:Text('Selecione a rota',style: Theme.of(context).textTheme.display1,textAlign: TextAlign.center,))
          ),
          result])));
    }

  Widget criarLista(List<Rota> rotas){
    return
      ListView.builder(itemCount: rotas.length,
          itemBuilder: (BuildContext context,int index){
        return
          Card(child:
            ListTile(leading: Container(height: 71.5,
            width: 80,margin: EdgeInsets.all(0),
            child: Icon(Icons.poll,size: 50,color: Theme.of(context).primaryColor,)),
            contentPadding: EdgeInsets.only(right: .2,left: 0),
            title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.group),
                Text(rotas[index].rota,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 21),),
              ],
            ),
            /*   subtitle:
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
              Icon(Icons.directions),
              Text(rotas[index].rota,style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),),
              ],
            ), */
            trailing: Container(height: 71.5,margin: EdgeInsets.all(0),
            width: 80,child: IconButton(icon:Icon(Icons.navigate_next,size: 56,),
                onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(rota: rotas[index],)));
                },
              ),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(3),
                topRight: Radius.circular(3))),),
            ),
            color: Theme.of(context).accentColor,);
        }
        );
  }

}
