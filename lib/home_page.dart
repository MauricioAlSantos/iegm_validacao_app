import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iegm_validacao_app/iegm_classes.dart';

final String mainIconName='assets/recalculo_ano.svg';

class HomePage extends StatefulWidget{
  static String tag = 'home_page';
  final Rota rota;

   // In the constructor, require a Todo
  HomePage({Key key, @required this.rota}) : super(key: key);

  @override
  _HomePageState createState()=> new _HomePageState(rota);
}

Future<Post> post = fetchPost();

Future<Post> fetchPost() async {
  final response =
  await http.get('http://services.groupkt.com/state/get/IND/UP');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {

    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

List<Remessa> remessas = loadRemessas();
loadRemessas(){
  List<Remessa> remessas=[];
  remessas.clear();
  Remessa r = Remessa(1,'São Luís');
  remessas.add(r);
  remessas.add(Remessa(2,'Imperatriz'));

  return remessas;
}

class _HomePageState extends State<HomePage>{
  EnteRota remessaSelecionada;
  
  Rota rota;
  Future<List<EnteRota>> entes;
  _HomePageState(Rota rota){
    this.rota =rota;
    entes = fetchEntesRota(rota);  
  }

   

  @override
  Widget build(BuildContext context){

   var listaEntes =FutureBuilder<List<EnteRota>>(
      future: entes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildDropDownRemessa(context,snapshot.data);
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Card(child:Text("Ocorreu um erro"));
        }
        // By default, show a loading spinner
        return CircularProgressIndicator();
      },
    );
 

  return new Scaffold (
  appBar: PreferredSize(preferredSize: Size(double.infinity,64),child:AppBar(elevation: 0,
  backgroundColor: Color.fromRGBO(251, 251, 251, 1),
  leading: Container(padding:EdgeInsets.only(left: 5,top: 3),margin: EdgeInsets.all(0),height: 57.67,
  child: Image.asset('assets/iegm_icon_2019.png')),
  title: Container(margin: EdgeInsets.all(0),padding:EdgeInsets.all(0) ,width: double.infinity,
    child:Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Text("Índice de Efetividade da Gestão Municipal",style: TextStyle(fontSize: 14),),
    Text("Tribunal de Contas do Estado do Maranhão",style: TextStyle(fontSize: 12)),
    ])))),
  drawer: buildDrawer(),
  body: Column(mainAxisSize: MainAxisSize.max,
        children:[
          Column(
            children:<Widget>[ 
              Padding(child:
              Builder(
                  // Create an inner BuildContext so that the onPressed methods
                  // can refer to the Scaffold with Scaffold.of().
                   builder: (BuildContext context){ return listaEntes;}),padding: EdgeInsets.only(top: 20,bottom:10)
                   ),
                Stack(children: [Container(color: Color.fromRGBO(251, 251,251, 1),child:(buildQuesito()),margin: EdgeInsets.only(top: 16),
                padding: EdgeInsets.only(top:10),),
                buildIndice(),
                ]),
            
              Row(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.center,children:[
                FlatButton(padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),child: CustomPaint(size: Size(50, 50),painter: new ArrowPainter(55.0,50.0,Theme.of(context).accentColor)),
                  onPressed: (){},),
                FlatButton(child: Transform.rotate( angle: .8, child:
                  Container(height: 45,width: 45,color: Theme.of(context).accentColor)),onPressed: (){},),
                FlatButton(padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),child: Transform.scale(scale:-1.0,child:
                  CustomPaint(size: Size(50, 50),painter: new ArrowPainter(55.0,50.0,Theme.of(context).accentColor))),
                onPressed: (){},)
            ])
        ])
      ])
  );
  }

  Widget buildDrawer(){
    return Drawer(child:
  ListView(children:<Widget>[
    Container(child:
      DrawerHeader(child: Text('Índices',style: TextStyle(color: Colors.white,fontSize: 35),),
      decoration: BoxDecoration(
      color: Color.fromRGBO(96, 126, 166, 1),
      ),
      padding: EdgeInsets.only(top:120,left: 10))
    ),
  ListTile(title: Text(rota.getRota())),
  ListTile(leading: Icon(Icons.change_history),title: Text('Change history'),
  onTap: () { Navigator.pop(context);},
  )
  ])
  );
  }
 
 
  Widget buildQuesito(){
     var listaSelecao = FutureBuilder<List<EnteRota>>(
      future: entes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildDropDownSelecao(snapshot.data);
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Card(child:Text("Ocorreu um erro"));
        }
        // By default, show a loading spinner
        return CircularProgressIndicator();
      },
    );
    return  Table(
      children:[
          TableRow(children:[
            Container(height: 156,margin: EdgeInsets.only(bottom: 20),child:
              Padding(padding: EdgeInsets.only(left: 10,right: 10,top:30),child:
                Text("Qual o percentual de unidades com sala de vacinação com funcionamento em 05 dias da semana?",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify
                  )
                )
              )
          ]),
          TableRow(children: [listaSelecao]),
          TableRow(children: [buildSubquesitosButton()]),
            
      ]);
  }
  
  Widget buildSubquesitosButton (){

    return Row(crossAxisAlignment: CrossAxisAlignment.center, children:[
      Expanded(flex: 12,child:Row(crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,children: [
        Container(height: 39.58,width: 153.22,margin: EdgeInsets.only(top:40, bottom: 40),
        child:
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () {
              
            },
            color: Theme.of(context).accentColor,
            child: Text('Subquesitos',style: TextStyle(fontSize: 16))
          ),
        )
      ])), 
      Expanded(flex:5,child:
        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,children:[
          
            Container(decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(width: 0),color:Theme.of(context).accentColor),
            margin: EdgeInsets.only(left: 30),padding: EdgeInsets.all(3.5),height: 55,width: 55,
            child:
            RaisedButton(shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45),
            ) ,
                child:Icon(Icons.check,size: 40,color: Theme.of(context).accentColor,),padding: EdgeInsets.all(0),
                onPressed: (){

                },
                color: Theme.of(context).primaryColor,
            )
          ) 
        ])
    )]);
  }
  Widget buildDropDownRemessa(BuildContext context, List<EnteRota> listaEntes){
      
      return Row(children:<Widget>[
        Container(width:35.5,height: 38.5,
          child:RaisedButton(padding: EdgeInsets.all(0),elevation: 0.1,shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(3.0),bottomRight: Radius.circular(3.0))),
          child: Icon(Icons.menu,size: 28,
          color:Color.fromRGBO(117, 115, 115, 1) ,),onPressed:(){Scaffold.of(context).openDrawer();})
        ),
        Expanded(child: 
          Container(height: 38.5,padding: EdgeInsets.only(left: 10),margin: EdgeInsets.only(left: 5),
              decoration: 
                BoxDecoration(color:  Color.fromRGBO(95, 126, 166, 1),
                  borderRadius:  BorderRadius.only(topLeft: Radius.circular(3.0),bottomLeft: Radius.circular(3.0))),
              child:
              Theme(data: Theme.of(context).copyWith(canvasColor: Color.fromRGBO(95, 126, 166, 1)),
              child: 
              DropdownButtonHideUnderline(
                child:DropdownButton(elevation: 0,iconSize: 40,
                  style:TextStyle(decoration: null,fontFamily: "OpenSans",
                  color:  Color.fromRGBO(242, 242, 242, 1)),
              isDense: false,
              hint: Text('Selecionar Município',style: TextStyle(color: Color.fromRGBO(251, 251, 251, 1),fontSize: 18),),
              isExpanded: true,
              value: remessaSelecionada,
              items: listaEntes.map((EnteRota r) {
                return DropdownMenuItem(
                  value: r,
                  child: Text(r.getNomeEnte(), style: TextStyle(fontSize: 18))
                );
              }).toList(),
              onChanged: ((EnteRota r){
                remessaSelecionada = r;
                setState(() {});
              })),
            ))
          )
        )
      ]
    );
  }
  Widget buildIndice(){
      return Row(children: [
          Container(decoration: BoxDecoration(color: Theme.of(context).accentColor,boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, .3),blurRadius: 2,offset: Offset(0, 1))]),
            height: 32.73,width: 126.69,child:Align(alignment: Alignment.centerLeft,child:
            Text('Saúde',style: TextStyle(fontSize: 14,color: Color.fromRGBO(250, 250, 250, 1.0),fontFamily: "OpenSans"))),padding: EdgeInsets.only(left:9,right:9),
            margin: EdgeInsets.only(right: 5),),
          
          Container(decoration: BoxDecoration(color: Theme.of(context).accentColor,boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, .3),blurRadius: 2,offset: Offset(0, 1))]),height: 32.73,child:Align(alignment: Alignment.centerLeft,child:
            Text('16',style: TextStyle(fontSize: 15,color: Color.fromRGBO(250, 250, 250, 1.0)))),padding: EdgeInsets.only(left:9,right:9),),
          
          ]);
  }
 /*  Widget buildDropDownIndice(){

    return Row(children:<Widget>[
      Container(color:Color.fromRGBO(96, 126, 166, 1),child:Padding(child:
      Text('Município',style: TextStyle(fontSize: 20)),padding: EdgeInsets.only(left: 5)),padding: EdgeInsets.all(9),),
      Expanded(child:
        Padding(
            padding: EdgeInsets.only(left: 10),
            child:
            DropdownButton(
              isDense: false,
              hint: Text('Selecionar Município'),
              isExpanded: true,
              value: remessaSelecionada,
              items: listaEnte.map((EnteRota r) {
                return DropdownMenuItem(
                  value: r,
                  child: Text(r.getNomeEnte(), style: TextStyle(fontSize: 20))
                );
              }).toList(),
              onChanged: ((EnteRota r){
                remessaSelecionada = r;
                setState(() {});
              }),
            )
          )
        )
      ]
    );
}
 */
  Widget buildDropDownSelecao(List<EnteRota> listaEntes){

    return  Row(children:[
      Expanded(child: 
            Container(height: 38.5,
              decoration: 
                BoxDecoration(color:  Color.fromRGBO(223, 231, 240, 1),
                  borderRadius:  BorderRadius.only(topLeft: Radius.circular(3.0),bottomLeft: Radius.circular(3.0))),
              child: Theme(data: Theme.of(context).copyWith(canvasColor: Color.fromRGBO(223, 231, 240, 1)),
              child: DropdownButtonHideUnderline(
                child:DropdownButton(elevation: 0,iconSize: 40,
                  style:TextStyle(decoration: null,fontFamily: "OpenSans",fontSize: 14,
                  color:  Color.fromRGBO(68, 66, 66, 1)),
              isDense: false,
              hint: Center(child:Text('Selecionar Município',style: TextStyle(color: Color.fromRGBO(68, 66, 66, 1))),),
              isExpanded: true,
              value: remessaSelecionada,
              items: listaEntes.map((EnteRota r) {
                return 
                  DropdownMenuItem(
                  value: r,
                  child: Center(child:
                      Text(r.nomeEnte, style: TextStyle(fontFamily: "OpenSans",fontSize: 14,))                        
                        )
                );
              }).toList(),
              onChanged: ((EnteRota r){
                remessaSelecionada = r;
                setState(() {});
              })),
            ))
          )
    )]);
  }
}

class ArrowPainter extends CustomPainter{
  var _height;
  var _color;
  var _width;

    
    ArrowPainter(this._width,this._height,this._color);
    @override
    void paint(Canvas canvas, Size size) {
      Path path = new Path();
      path.addPolygon([Offset(this._height/2,this._height/2),Offset(this._width,0),Offset(this._width,this._height)], true);
      canvas.drawPath( path,Paint()..color=this._color);
    }
    Paint getPaint(Color color){
        Paint paint = Paint();
        paint.color = color;
        return paint;
    }
    @override
    bool shouldRepaint(CustomPainter oldDelegate) {
      return oldDelegate!= this;
    }
    
  }


class Remessa{
  int remessaId;
  String nome;
  Remessa(int id,String nome){
    this.remessaId=id;
    this.nome=nome;
  }
}
class Post {
  final String country;
  final String name;
  final String abbr;
  final String area;
  final String largestCity;
  final String capital;

  Post({this.country, this.name, this.abbr, this.area,
    this.largestCity, this.capital});

  factory Post.fromJson(Map<String, dynamic> json) {

    return Post(
        country : json['RestResponse']['result']['country'],
        name : json['RestResponse']['result']['name'],
        abbr : json['RestResponse']['result']['abbr'],
        area : json['RestResponse']['result']['area'],
        largestCity : json['RestResponse']['result']['largest_city'],
        capital : json['RestResponse']['result']['capital'],
    );
  }
}


