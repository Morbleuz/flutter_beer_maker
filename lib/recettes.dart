import 'package:flutter/material.dart';
import 'package:flutter_beer_maker/model/beer.dart';
import 'package:flutter_beer_maker/viewmodel/appbar.dart';
import 'package:flutter_beer_maker/viewmodel/logoandtext.dart';
import 'package:flutter_beer_maker/viewmodel/showbeer.dart';

class Recette extends StatefulWidget {
  const Recette({super.key});

  @override
  State<StatefulWidget> createState() => _Recette();
}

class _Recette extends State<Recette> {
  final List<Beer> _lesBieres = [Beer(5, 2, 1)];
  List<Widget> _content = [LogoAndText(text: 'Vos recettes')];
  //Clef pour le refresh
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  _clearContent() {
    setState(() {
      _content = [LogoAndText(text: 'Vos recettes')];
    });
  }

  Future<void> _initBiere() async {
    _clearContent();
    for (Beer beer in _lesBieres) {
      //Faire la méthode pour récupérer des bières
      _content.add(ShowBeer(beer: 'azd'));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBeerMaker(),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () => _initBiere(),
        child: ListView(
          children: [
            Column(children: _content),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(30),
        child: IconButton(
            tooltip: 'Appuyez sur le bouton pour refresh',
            style: ButtonStyle(),
            onPressed: _initBiere,
            icon: const Icon(
              Icons.refresh,
              color: Colors.green,
              size: 30,
            )),
      ),
    );
  }
}
