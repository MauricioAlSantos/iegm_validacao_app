import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class HomePage extends StatefulWidget{
   static String tag = 'home_page';

  @override
  _HomePageState createState()=> new _HomePageState();



}

Future<List<String>> _getBdData() async{
  var connection = new PostgreSQLConnection("10.0.0.103", 5432, "tce", username: "postgres", password: "postgres",useSSL: false);
  await connection.open();
  try {
    String sql= "select r.nome_ente from iegm.remessa r where r.ano = 2016 ";
    List<Map<String, Map<String, dynamic>>> results = await connection.mappedResultsQuery(sql);
    List<String> texto= new List<String>();
    for(final row in results){
      texto.add(row["remessa"]["nome_ente"]);
    }
    return texto;
  }finally{
    connection.close();
  }
}

Future<List<Widget>> texto = _getBdData().then((List<String> texto){
  var widgets= new List<Widget>();
  for(String item in texto){
    widgets.add(new Text(item));
  }
   return widgets;
});

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context){
    var nome = "Teste";
    var result = FutureBuilder<List<Widget>>(
      future: texto, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
             return CircularProgressIndicator();
          case ConnectionState.done:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            return new ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0,bottom: 15.0),
                separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: snapshot.data[index],
                );},
                itemCount: snapshot.data.length
            );
            //return new ListBody(children:[Text("Um"),Text("Dois")]);
        }
        return null; // unreachable
      },
    );
    return new Scaffold ( backgroundColor: Colors.white,
      body: Center(
          child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: [new Text("Lista de Entes"),result]
          )
      ),
    );
  }
}