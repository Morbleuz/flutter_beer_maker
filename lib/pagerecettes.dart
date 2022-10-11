import 'package:flutter/material.dart';
import 'package:flutter_beer_maker/model/api.dart';
import 'package:flutter_beer_maker/model/beer.dart';
import 'package:flutter_beer_maker/model/recipe.dart';
import 'package:flutter_beer_maker/viewmodel/appbar.dart';
import 'package:flutter_beer_maker/viewmodel/logoandtext.dart';
import 'package:flutter_beer_maker/viewmodel/showbeer.dart';

class Recette extends StatefulWidget {
  const Recette({super.key});

  @override
  State<StatefulWidget> createState() => _Recette();
}

class _Recette extends State<Recette> {
  List<Recipe> _lesRecettes = [];
  List<Widget> _content = [LogoAndText(text: 'Vos recettes')];
  //Clef pour le refresh
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  _clearContent() {
    setState(() {
      _content = [LogoAndText(text: 'Vos recettes')];
    });
  }

  Future<void> _supprimeRecipe(Recipe recette) async {
    await API.deleteUneRecipe(recette.id);
    setState(() {});
  }

  Future<void> _initBiere() async {
    _clearContent();
    _lesRecettes = await API.recupData();
    for (Recipe recette in _lesRecettes) {
      //Faire la méthode pour récupérer des bières
      _content.add(ShowBeer(
          recette: recette, supprimer: ((p0) => (_supprimeRecipe(recette)))));
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
        child: FloatingActionButton(
            tooltip: 'Appuyez sur le bouton pour refresh',
            backgroundColor: const Color.fromARGB(255, 60, 141, 63),
            hoverColor: const Color.fromARGB(255, 42, 97, 43),
            onPressed: _initBiere,
            child: const Icon(
              Icons.refresh,
              color: Colors.white,
              size: 30,
            )),
      ),
    );
  }
}
