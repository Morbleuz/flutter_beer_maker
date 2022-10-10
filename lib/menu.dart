import 'package:flutter/material.dart';
import 'package:flutter_beer_maker/viewmodel/appbar.dart';
import 'package:flutter_beer_maker/viewmodel/buttonmenu.dart';
import 'package:flutter_beer_maker/viewmodel/logoandtext.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBarBeerMaker(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              LogoAndText(text: 'BeerMaker'),
              const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Choissisez une option !',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              ButtonMenu(
                  text: 'Etape de Fabrication',
                  action: () => Navigator.pushNamed(context, '/etapes')),
              ButtonMenu(
                text: 'Fabrication   ',
                action: () => Navigator.pushNamed(context, '/fabrication'),
              ),
              ButtonMenu(
                  text: 'Vos recettes   ',
                  action: () => Navigator.pushNamed(context, '/recettes'))
            ],
          ),
        ),
      ),
    );
  }
}
