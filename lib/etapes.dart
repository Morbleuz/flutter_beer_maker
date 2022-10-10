import 'package:flutter/material.dart';
import 'package:flutter_beer_maker/model/string.dart';
import 'package:flutter_beer_maker/viewmodel/appbar.dart';

class Etapes extends StatefulWidget {
  Etapes({super.key});

  @override
  @override
  State<StatefulWidget> createState() => _Etapes();
}

class _Etapes extends State<Etapes> {
  int index = 0;
  List<Map> lesPages = Strings.lesPages;

  void _incrementIndex() {
    setState(() {
      if (index < lesPages.length) {
        index++;
      }
    });
  }

  void _decrementIndex() {
    setState(() {
      if (index > 0) {
        index--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBeerMaker(),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: afficheEtapes(index),
        )),
      ),
    );
  }

  Widget afficheEtapes(int index) {
    Widget container = Container();
    setState(() {
      if (index == lesPages.length) {
        container =
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset("assets/images/step/end.gif",
              height: 400.0, width: 400.0),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('L\'alcool est à consommer sans modération.'),
                  const Text('Bonne dégustation !'),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [_montreArrowBack(), _montreArrowNext()],
          ),
        ]);
      } else {
        container =
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            '${lesPages[index]['texte'][0]}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text('${lesPages[index]['texte'][1]}'),
          ),
          const Text(
            'Images annexes',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _AjoutePhotosAUneListe(index, context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [_montreArrowBack(), _montreArrowNext()],
          ),
        ]);
      }
    });

    return container;
  }

  //Deux fonctions pour ajouter dynamiquements à une colonnes
  // des images
  Widget _CreateImageAsset(String uri, context) {
    return SizedBox(
        width: 300, height: 300, child: Image.asset('assets/images/step/$uri'));
  }

  Widget _AjoutePhotosAUneListe(int index, context) {
    Widget container = Container();
    Widget column = Column();
    List<Widget> image = [];
    if (lesPages[index]['images'].isNotEmpty) {
      for (String uri in lesPages[index]['images']) {
        image.add(_CreateImageAsset(uri, context));
      }
      container = Column(
        children: image,
      );
    }
    return container;
  }

  //Deux fonctions pour avoir soit un Container vide ou le bouton associé
  // à l'incrémentation ou la décrémentation
  Widget _montreArrowNext() {
    Widget child = Container();
    setState(() {
      if (index < lesPages.length) {
        child = IconButton(
            onPressed: _incrementIndex,
            icon: const Icon(Icons.keyboard_arrow_right));
      } else {
        child = Container(
          height: 10,
          width: 10,
        );
      }
    });
    return child;
  }

  Widget _montreArrowBack() {
    Widget child = Container();
    setState(() {
      if (index > 0) {
        child = IconButton(
            onPressed: _decrementIndex,
            icon: const Icon(Icons.keyboard_arrow_left));
      } else {
        child = Container(
          height: 10,
          width: 10,
        );
      }
    });
    return child;
  }
}
