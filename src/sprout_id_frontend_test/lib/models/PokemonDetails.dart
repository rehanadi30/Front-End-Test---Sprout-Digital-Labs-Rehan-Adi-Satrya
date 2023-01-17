import 'PokemonSprites.dart';

class PokemonDetails {
  String name;
  int weight;
  int height;
  PokemonSprites pokemonSprites;

  PokemonDetails({this.name, this.weight, this.height, this.pokemonSprites});

  PokemonDetails.fromJson(Map<String, dynamic> json){
    name = json['name'];
    weight = json['weight'];
    height = json['height'];
    pokemonSprites = PokemonSprites.fromJson(json['sprites']);
  }
}