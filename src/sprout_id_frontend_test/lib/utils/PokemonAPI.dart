import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sprout_id_frontend_test/models/PokemonResponse.dart';

import '../models/PokemonDetails.dart';

class PokemonApi {
  
  Future<PokemonResponse> getPokemon(int offset) async {
    final res = await http.get('https://pokeapi.co/api/v2/pokemon?offset=${offset.toString()}&limit=20');
    
    if(res.statusCode == 200) {
      return PokemonResponse.fromJson(jsonDecode(res.body));
    }
  }

  Future<PokemonDetails> getPokemonDetails(url) async {
    final res = await http.get(url);
    if(res.statusCode==200){
      return PokemonDetails.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load from API');
    }
  }
}