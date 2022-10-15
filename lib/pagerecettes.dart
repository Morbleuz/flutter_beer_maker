import 'package:flutter/material.dart';
import 'package:flutter_beer_maker/model/api.dart';
import 'package:flutter_beer_maker/model/recette.dart';
import 'package:flutter_beer_maker/viewmodel/appbar.dart';
import 'package:flutter_beer_maker/viewmodel/logoandtext.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PageRecette extends StatefulWidget {
  const PageRecette({super.key});

  @override
  State<StatefulWidget> createState() => _PageRecette();
}

class _PageRecette extends State<PageRecette> {
  List<Recette> _lesRecettes = [];
  List<Widget> _content = [LogoAndText(text: 'Vos recettes')];
  //Clef pour le refresh
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  _clearContent() {
    setState(() {
      _content = [LogoAndText(text: 'Vos recettes')];
    });
  }

  Future<void> _supprimeRecipe(Recette recette) async {
    print('azd');
    await API.deleteUneRecipe(recette);
    _initBiere();
  }
  /*

  BLOC A REVOIR POUR LA SUPPRESION D'UNE RECETTE

  */

  Future<void> _initBiere() async {
    _clearContent();
    _lesRecettes = await API.recupData();
    if (_lesRecettes.isNotEmpty) {
      for (Recette recette in _lesRecettes) {
        //Faire la méthode pour récupérer des bières
        _content.add(_showUneRecipe(recette));
      }
    } else {
      _content.add(Text('Vous n\'avez pas de recette'));
    }

    setState(() {});
  }

  Future<void> _showInformationBeer(Recette recette) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Information sur la bière'),
              content: Container(
                color: Color.fromARGB(90, 216, 216, 216),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          'Quantité à prévoir',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'Quantité de malt : ${recette.calculQteMaltKg()} Kg',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                          'Volume eau de brassage : ${recette.calculQteEauBrassageL()} L '),
                      Text(
                          'Volume eau de rinçage : ${recette.calculQteEauRincageL()} L'),
                      Text(
                          'Quantité de houblon amérisant : ${recette.calculQteHoublonAmerisantG()} G'),
                      Text(
                          'Quantité de houblon aromatique: ${recette.calculQteHoublonAromatiqueG()} G'),
                      Text(
                          'Quantité de levure : ${recette.calculQteLevureG()} G'),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Colorimétrie',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('MCU = ${recette.calculMCU()}'),
                                  Text('EBC = ${recette.calculEBC()}'),
                                  Text('SRM = ${recette.calculSRM()}'),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                width: 150,
                                height: 70,
                                color: Color(
                                    recette.srmToRGB(recette.calculSRM())),
                                child: Center(
                                    child: Text(
                                        '#${recette.srmToRGB(recette.calculSRM()).toRadixString(16).substring(2)}')),
                              ),
                            )
                          ]),
                    ],
                  ),
                ),
              ));
        });
  }

  Widget _showUneRecipe(Recette recette) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Slidable(
          key: const ValueKey(0),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                autoClose: true,
                icon: Icons.info,
                label: 'Information',
                onPressed: (context) => _showInformationBeer(recette),
                backgroundColor: Color.fromARGB(255, 227, 205, 2),
                foregroundColor: Colors.white,
                borderRadius: BorderRadius.circular(9),
              ),
              SlidableAction(
                autoClose: true,
                icon: Icons.delete,
                label: 'Supprimer',
                onPressed: ((context) => _supprimeRecipe(recette)),
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.circular(9),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(recette.srmToRGB(recette.calculSRM())),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          recette.getNom(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('${recette.getVolumeLitre()} L'),
                        Text('${recette.getDegreAlcool()} degrès')
                      ],
                    )
                  ]),
            ),
          ),
        ));
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
