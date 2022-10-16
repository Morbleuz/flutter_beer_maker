import 'package:flutter/material.dart';
import 'package:flutter_beer_maker/viewmodel/appbar.dart';
import 'package:flutter_beer_maker/viewmodel/buttonmenu.dart';
import 'package:flutter_beer_maker/viewmodel/logoandtext.dart';

import 'model/api.dart';

class Menu extends StatefulWidget {
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Widget body = Scaffold(
    appBar: AppBarBeerMaker(),
    body: Center(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
        Text('Chargement de l\'api'),
        CircularProgressIndicator(
          color: Colors.black,
        )
      ]),
    ),
  );

  void attentionApi() {
    body = Scaffold(
      appBar: AppBarBeerMaker(),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Chargement de l\'api'),
              CircularProgressIndicator(
                color: Colors.black,
              )
            ]),
      ),
    );
  }

  //Fonction pour changer le body en fonction du test de connexion de l'api
  void menuSiApiNotOK() {
    body = Scaffold(
      appBar: AppBarBeerMaker(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child:
                  Text('Impossible d\'établir une communication avec l\'api'),
            ),
            ElevatedButton(
                onPressed: () => testConnexionApi(),
                child: Text('Reesayer la connexion'))
          ],
        ),
      ),
    );
  }

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

  //Fonction pour test l'api
  Future<void> testConnexionApi() async {
    setState(() {
      attentionApi();
    });
    if (await API.testCommunication()) {
      menuSiApiOK();
    } else {
      menuSiApiNotOK();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    testConnexionApi();
  }

  @override
  Widget build(BuildContext context) {
    return body;
  }
}
