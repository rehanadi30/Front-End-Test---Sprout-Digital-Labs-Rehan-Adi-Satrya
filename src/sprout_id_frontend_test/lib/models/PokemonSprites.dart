class PokemonSprites {
  String front;
  String back;

  PokemonSprites({this.front, this.back});

  PokemonSprites.fromJson(Map<String, dynamic> json){
    front = json['front_default'];
    back = json['back_default'];
  }
}