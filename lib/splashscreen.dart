import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_beer_maker/model/api.dart';
import 'package:flutter_beer_maker/myhomepage.dart';

import 'menu.dart';

class SplashScreen extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Menu(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bgor.png'),
                fit: BoxFit.cover)),
        child:
            SizedBox(child: Image.asset('assets/images/beermakerlogo1000.png')),
      ),
    );
  }
}
