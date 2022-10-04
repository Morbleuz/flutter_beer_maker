import 'package:flutter/material.dart';

class AppBarBeerMaker extends AppBar {
  AppBarBeerMaker({super.key})
      : super(
          title: const SizedBox(
            child: Text('Beer maker 🍺'),
          ),
          backgroundColor: Colors.green,
        );
}
