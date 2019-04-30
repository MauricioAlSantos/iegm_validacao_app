import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget{
   static String tag = 'home_page';
   
  @override
  _HomePageState createState()=> new _HomePageState();
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

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context){
    var nome = "Teste";
    var result = FutureBuilder<Post>(
      future: post,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.name);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner
        return CircularProgressIndicator();
      },
    );
    return new Scaffold ( backgroundColor: Colors.white,
      body: Center(
        child: result
      ),
    );
  }
}

class Post {
  final String country;
  final String name;
  final String abbr;
  final String area;
  final String largestCity;
  final String capital;

  Post({this.country, this.name, this.abbr, this.area, this.largestCity, this.capital});

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