import 'dart:io';

import 'dart:async';

import 'dart:convert';

class Rota{
  String rota;
  
  Rota({this.rota});
  factory Rota.fromJson(Map<String, dynamic> json) {
    return Rota(rota:json['rota'],);
    }
  String getRota() {
    return this.rota;
  }
  void setRota(String rota) {
    this.rota = rota;
  }
}
Future<List<Rota>> fetchRotas() async {
    List<dynamic> itens;
    List<Rota> rotas = List();
    HttpClientResponse resp;
   
    String host = 'http://www5.tce.ma.gov.br/iegm_service/rs/IegmService/rotas';
    var client = new HttpClient();
    client.badCertificateCallback = (_, __, ___) => true;
    Future<HttpClientResponse> req = client.getUrl(Uri.parse(host)).then((req){
      return req.close();
      }).then((v){
        return v;
      });
    
    resp = (await req.then((v){return v;}));
    String valor = await resp.transform(Utf8Decoder()).join('').then((v){return v;});
    //await resp.transform(Utf8Decoder()).join('').then((v){valor=v;});
    //print(valor);
    if(resp.statusCode==200){
                
                itens =  JsonDecoder().convert(valor);
                
                //itens.forEach((item){print(item['rota']);});
              
                itens.forEach((item){
                  rotas.add(Rota.fromJson(item));
                });
                return rotas;
               
    }else {
          // If that response was not OK, throw an error.
            throw Exception('Failed to load post');
    }
  }


class EnteRota{
  int enteId;
  String rota;
  String equipe;
  String nomeEnte;

  EnteRota({this.enteId,this.rota,this.equipe,this.nomeEnte});
  factory EnteRota.fromJson(Map<String, dynamic> json) {
    return EnteRota(
    enteId: json['ente_id'],
    rota:json['rota'],
    equipe:json['equipe'],
    nomeEnte:json['nomeEnte']
    );
    }

   String getNomeEnte() {
    return nomeEnte;
  }

  void setNomeEnte(String nomeEnte) {
    this.nomeEnte = nomeEnte;
  }
  int getEnteId() {
    return enteId;
  }
   void setEnteId(int enteId) {
    this.enteId = enteId;
  }
  String getRota() {
    return this.rota;
  }
  void setRota(String rota) {
    this.rota = rota;
  }
  String getEquipe() {
    return equipe;
  }
  void setEquipe(String equipe) {
    this.equipe = equipe;
  }
}

Future<List<EnteRota>> fetchEntesRota(Rota rota) async {
    List<dynamic> itens;
    List<EnteRota> rotas = List();
    HttpClientResponse resp;
   
    String host = 'http://www5.tce.ma.gov.br/iegm_service/rs/IegmService/entesRota/'+rota.getRota();
    var client = new HttpClient();
    client.badCertificateCallback = (_, __, ___) => true;
    Future<HttpClientResponse> req = client.getUrl(Uri.parse(host)).then((req){
      return req.close();
      }).then((v){
        return v;
      });
    
    resp = (await req.then((v){return v;}));
    String valor = await resp.transform(Utf8Decoder()).join('').then((v){return v;});
    
    //print(valor);
    if(resp.statusCode==200){
                
                itens =  JsonDecoder().convert(valor);
                
                //itens.forEach((item){print(item['rota']);});
              
                itens.forEach((item){
                  rotas.add(EnteRota.fromJson(item));
                });
                return rotas;
               
    }else {
          // If that response was not OK, throw an error.
            throw Exception('Failed to load post');
    }
  }

class QuesitoValidavel{

}
class SubquesitoValidavel{

}
class RemessaValidavel{}
class UsuarioValidacao{}