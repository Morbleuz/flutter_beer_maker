import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'recette.dart';

abstract class API {
  static Future<bool> testCommunication() async {
    bool connected = true;
    http.Response reponse = await http.get(Uri.parse(
        'https://s3-4440.nuage-peda.fr/apiBeerMaker/public/api/recettes'));
    if (reponse.statusCode != 200) {
      connected = false;
    }
    return connected;
  }

  static Future<List<Recette>> recupData() async {
    List<Recette> lesNouvellesRecettes = [];

    http.Response reponse = await http.get(Uri.parse(
        'https://s3-4440.nuage-peda.fr/apiBeerMaker/public/api/recettes'));
    Map<String, dynamic> data = {};
    if (reponse.statusCode == 200) {
      data = convert.jsonDecode(reponse.body);
      List<dynamic> newData = data["hydra:member"];

      for (Map recette in newData) {
        //On récupérer l'url d'une bière
        print(recette);
        print(recette["volumeLitre"].toDouble());

        lesNouvellesRecettes.add(Recette.create(
            recette["id"],
            recette["nom"],
            recette["volumeLitre"].toDouble(),
            recette["degreAlcool"].toDouble(),
            recette["moyenneEBC"].toDouble()));
      }
    }
    return lesNouvellesRecettes;
  }

  static Future<http.Response> createRecette(Recette recette) {
    print(recette.getNom());
    return http.post(
      Uri.parse(
          'https://s3-4440.nuage-peda.fr/apiBeerMaker/public/api/recettes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, dynamic>{
        'nom': recette.getNom(),
        'volumeLitre': recette.getVolumeLitre(),
        'moyenneEBC': recette.getMoyenneEBC(),
        'degreAlcool': recette.getDegreAlcool()
      }),
    );
  }

  static Future<void> deleteUneRecipe(Recette recette) async {
    http.Response response = await http.delete(
      Uri.parse(
          'https://s3-4440.nuage-peda.fr/apiBeerMaker/public/api/recettes/${recette.getId()}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
  }

  /*
  static Future<Beer> recupUneBeer(String url) async {
    http.Response reponse =
        await http.get(Uri.parse('https://s3-4440.nuage-peda.fr$url'));
    Beer beer = Beer.vide();
    Map<String, dynamic> data = {};
    if (reponse.statusCode == 200) {
      data = convert.jsonDecode(reponse.body);
      beer.changeParametre(
          data["volumeLitre"], data["degreAlcool"], data["moyenneEBC"]);
    }
    return beer;
  }
  */
}
