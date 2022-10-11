import 'package:flutter_beer_maker/model/beer.dart';

class Recipe {
  final id;
  final String _titre;
  final _beer;

  Recipe(this._beer, this._titre, this.id);

  Beer getBeer() {
    return _beer;
  }

  String getTitre() {
    return _titre;
  }
}
