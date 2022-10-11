import 'package:flutter/material.dart';
import 'package:flutter_beer_maker/model/recipe.dart';
import 'package:flutter_beer_maker/pagerecettes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'beer.dart';

abstract class API {
  static Future<List<Recipe>> recupData() async {
    List<Recipe> lesNouvellesRecettes = [];
    http.Response reponse = await http.get(Uri.parse(
        'https://s3-4440.nuage-peda.fr/apiBeerMaker/public/api/recipes?page=1'));
    Map<String, dynamic> data = {};
    if (reponse.statusCode == 200) {
      data = convert.jsonDecode(reponse.body);
      List<dynamic> test = data["hydra:member"];
      for (Map recette in test) {
        //On récupérer l'url d'une bière
        String url = recette["beer"];
        Beer beer = await recupUneBeer(url);
        print(recette);
        lesNouvellesRecettes.add(Recipe(beer, recette["titre"], recette["id"]));
      }
    }
    return lesNouvellesRecettes;
  }

  static Future<void> deleteUneRecipe(Recipe recipe) async {
    http.Response response = await http.delete(
      Uri.parse(
          'https://s3-4440.nuage-peda.fr/apiBeerMaker/public/api/recipes/${recipe.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
  }

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
}
