import 'package:flutter/material.dart';
import 'package:flutter_beer_maker/etapes.dart';
import 'package:flutter_beer_maker/menu.dart';
import 'package:flutter_beer_maker/myhomepage.dart';
import 'package:flutter_beer_maker/pagerecettes.dart';

import 'fabrication.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Beer Maker',
        home: MyHomePage(),
        routes: <String, WidgetBuilder>{
          '/fabrication': (BuildContext context) => const Fabrication(),
          '/menu': (BuildContext context) => Menu(),
          '/etapes': (BuildContext context) => Etapes(),
          '/recettes': (BuildContext context) => const PageRecette()
        });
  }
}
