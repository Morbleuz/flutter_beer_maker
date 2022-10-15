import 'package:flutter/material.dart';
import 'package:flutter_beer_maker/viewmodel/appbar.dart';
import 'package:flutter_beer_maker/viewmodel/buttonmenu.dart';
import 'package:flutter_beer_maker/viewmodel/logoandtext.dart';

import 'model/api.dart';
import 'noconnected.dart';

class Menu extends StatefulWidget {
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Widget body = Center(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
      Text('Chargement de l\'api'),
      CircularProgressIndicator(
        color: Colors.black,
      )
    ]),
  );

  void menuSiApiOK() {
    body = Scaffold(
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

  Future<void> testConnexionApi() async {
    if (await API.testCommunication()) {
      Future.delayed(Duration(seconds: 10));
      menuSiApiOK();
    } else {
      Future.delayed(Duration(seconds: 10));

      body = NoConnected();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    testConnexionApi();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return body;
  }
}
