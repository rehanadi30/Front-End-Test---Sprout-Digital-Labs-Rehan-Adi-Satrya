import 'package:flutter/material.dart';
import 'package:sprout_id_frontend_test/utils/PokemonAPI.dart';

import '../models/PokemonDetails.dart';

class PokemonDetailsPage extends StatefulWidget {
  final String url;
  const PokemonDetailsPage({Key key, this.url}) : super(key: key);

  @override
  _PokemonDetailsState createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetailsPage> {

  Future<PokemonDetails> pokemonDetails;

  @override
  void initState() {
    super.initState();
    pokemonDetails = PokemonApi().getPokemonDetails(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: pokemonDetails,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final pokemonDetails = snapshot.data;

          return Scaffold(
            appBar: AppBar(
                title: Text('Details of ${capitalize(pokemonDetails.name)}')),
            body:
            Column(
              children: [
                Image.network(
                  '${pokemonDetails.pokemonSprites.front}', scale: 0.5,
                  alignment: Alignment.centerLeft,),
                Text('Front View'),
                Image.network(
                  '${pokemonDetails.pokemonSprites.back}', scale: 0.5,
                  alignment: Alignment.centerRight,),
                Text('Back View\n'),
                Text('Name: ${pokemonDetails.name}'),
                Text('Weight: ${pokemonDetails.weight}'),
                Text('Height: ${pokemonDetails.height}')
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();