import 'package:flutter/material.dart';
import 'package:flutter_beer_maker/viewmodel/logoandtext.dart';
import 'package:flutter_beer_maker/model/beer.dart';

class Fabrication extends StatefulWidget {
  const Fabrication({super.key});

  @override
  State<Fabrication> createState() => _Fabrication();
}

class _Fabrication extends State<Fabrication> {
  final _formKey = GlobalKey<FormState>();
  double _volumeBiere = 0;
  double _moyenneEBC = 0;
  double _degreAlcool = 0;
  bool isValid = false;
  Beer beer = Beer.vide();

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

  Widget afficheInfo() => Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          color: Color.fromARGB(90, 216, 216, 216),
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
                  'Quantité de malt : ${beer.calculQteMaltKg()} Kg',
                  textAlign: TextAlign.left,
                ),
                Text(
                    'Volume eau de brassage : ${beer.calculQteEauBrassageL()} L '),
                Text(
                    'Volume eau de rinçage : ${beer.calculQteEauRincageL()} L'),
                Text(
                    'Quantité de houblon amérisant : ${beer.calculQteHoublonAmerisantG()} G'),
                Text(
                    'Quantité de houblon aromatique: ${beer.calculQteHoublonAromatiqueG()} G'),
                Text('Quantité de levure : ${beer.calculQteLevureG()} G'),
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
                            Text('MCU = ${beer.calculMCU()}'),
                            Text('EBC = ${beer.calculEBC()}'),
                            Text('SRM = ${beer.calculSRM()}'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          width: 150,
                          height: 70,
                          color: Color(beer.srmToRGB(beer.calculSRM())),
                          child: Center(
                              child: Text(
                                  '#${beer.srmToRGB(beer.calculSRM()).toRadixString(16).substring(2)}')),
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
                          onPressed: () {},
                          child: const Text('ENREGISTRER LA RECETTE'))),
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
              beer.changeParametre(_volumeBiere, _degreAlcool, _moyenneEBC);
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
