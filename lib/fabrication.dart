import 'package:flutter/material.dart';
import 'package:flutter_beer_maker/model/api.dart';
import 'package:flutter_beer_maker/viewmodel/logoandtext.dart';
import 'package:flutter_beer_maker/model/recette.dart';

class Fabrication extends StatefulWidget {
  const Fabrication({super.key});

  @override
  State<Fabrication> createState() => _Fabrication();
}

class _Fabrication extends State<Fabrication> {
  final _formKey = GlobalKey<FormState>();
  final _formNewRecipeKey = GlobalKey<FormState>();

  double _volumeBiere = 0;
  double _moyenneEBC = 0;
  double _degreAlcool = 0;
  String _nomRecette = "";
  bool isValid = false;
  final _recette = Recette.vide();
  bool isEnvoyer = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SizedBox(
          child: Text('Beer maker 🍺'),
        ),
        backgroundColor: Colors.green,
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            children: [
              LogoAndText(
                text: 'Fabrication',
              ),
              enterVolume(),
              enterDegre(),
              enterMoyenneEBC(),
              calculer(),
              if (isValid) afficheInfo()
            ],
          )),
    );
  }

  void _envoieDeLaRecette(context) async {
    if (_formNewRecipeKey.currentState!.validate()) {
      String message = "";
      _recette.setNom(_nomRecette);
      if (await API.testCommunication()) {
        await API.createRecette(_recette);
        message = "Recette '$_nomRecette' correctement envoyer 🚀!";
      } else {
        message = "Impossible d'envoyer la recette.";
      }
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
    setState(() {});
  }

  Future<void> _showFormulaireEnvoieNewRecipe(
      BuildContext context, Recette recette) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajoutez une nouvelle recette'),
        content: Form(
            key: _formNewRecipeKey,
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Column(children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.keyboard),
                        labelText: 'Nom de la recette'),
                    validator: (valeur) {
                      if (valeur == null || valeur.isEmpty) {
                        return 'Veuillez saisir une valeur.';
                      } else {
                        try {
                          _nomRecette = valeur;
                        } catch (e) {
                          return 'Erreur';
                        }
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.green)),
                      onPressed: () => _envoieDeLaRecette(context),
                      child: const Icon(Icons.send),
                    ),
                  )
                ]))),
      ),
    );
  }

  Widget afficheInfo() => Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          color: const Color.fromARGB(90, 216, 216, 216),
          width: double.infinity,
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
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Quantité de malt : ${_recette.calculQteMaltKg()} Kg',
                  textAlign: TextAlign.left,
                ),
                Text(
                    'Volume eau de brassage : ${_recette.calculQteEauBrassageL()} L '),
                Text(
                    'Volume eau de rinçage : ${_recette.calculQteEauRincageL()} L'),
                Text(
                    'Quantité de houblon amérisant : ${_recette.calculQteHoublonAmerisantG()} G'),
                Text(
                    'Quantité de houblon aromatique: ${_recette.calculQteHoublonAromatiqueG()} G'),
                Text('Quantité de levure : ${_recette.calculQteLevureG()} G'),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Colorimétrie',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text('MCU = ${_recette.calculMCU()}'),
                            Text('EBC = ${_recette.calculEBC()}'),
                            Text('SRM = ${_recette.calculSRM()}'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          width: 150,
                          height: 70,
                          color: Color(_recette.srmToRGB(_recette.calculSRM())),
                          child: Center(
                              child: Text(
                                  '#${_recette.srmToRGB(_recette.calculSRM()).toRadixString(16).substring(2)}')),
                        ),
                      )
                    ]),
                Center(
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.green),
                          ),
                          onPressed: () =>
                              _showFormulaireEnvoieNewRecipe(context, _recette),
                          child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text('ENREGISTRER LA RECETTE')))),
                ),
              ],
            ),
          ),
        ),
      );
  Widget calculer() => Padding(
      padding: const EdgeInsets.all(25),
      child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.green)),
          onPressed: () {
            //Si le formulaire est valide
            if (_formKey.currentState!.validate()) {
              isValid = true;
              _recette.changeParametre(
                  0, "", _volumeBiere, _degreAlcool, _moyenneEBC);
            } else {
              isValid = false;
            }
            setState(() {});
          },
          child: const Text('CALCULER')));
  Widget enterMoyenneEBC() => SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            decoration: const InputDecoration(
                icon: Icon(Icons.grain),
                labelText: 'Moyenne EBC des grains utilisés '),
            validator: (valeur) {
              if (valeur == null || valeur.isEmpty) {
                return 'Veuillez saisir une valeur.';
              } else {
                try {
                  _moyenneEBC = double.parse(valeur);
                } catch (e) {
                  return 'Veuillez saisir un entier';
                }
              }
              return null;
            },
          ),
        ),
      );
  Widget enterVolume() => SizedBox(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            decoration: InputDecoration(
                icon: Icon(Icons.water_drop),
                labelText: 'Volume de bière  à frabriquer en L'),
            validator: (valeur) {
              if (valeur == null || valeur.isEmpty) {
                return 'Veuillez saisir une valeur.';
              } else {
                try {
                  _volumeBiere = double.parse(valeur);
                } catch (e) {
                  return 'Veuillez saisir un entier';
                }
              }
              return null;
            },
          ),
        ),
      );
  Widget enterDegre() => SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            decoration: const InputDecoration(
                icon: Icon(Icons.percent),
                labelText: 'Degré d\'alcool recherché en %'),
            validator: (valeur) {
              if (valeur == null || valeur.isEmpty) {
                return 'Veuillez saisir une valeur.';
              } else {
                try {
                  _degreAlcool = double.parse(valeur);
                } catch (e) {
                  return 'Veuillez saisir un entier';
                }
              }
              return null;
            },
          ),
        ),
      );
}
