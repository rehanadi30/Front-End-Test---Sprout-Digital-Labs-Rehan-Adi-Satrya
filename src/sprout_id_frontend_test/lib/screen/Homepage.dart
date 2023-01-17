import 'package:flutter/material.dart';
import 'package:sprout_id_frontend_test/models/PokemonResponse.dart';
import 'package:sprout_id_frontend_test/utils/PokemonAPI.dart';

import 'PokemonDetailsPage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeApps',
      home: MyHomePage(title: 'PokeApp Sprout Id Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<PokemonResponse> pokemonResponse;

  @override
  void initState() {
    super.initState();
    pokemonResponse = PokemonApi().getPokemon(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
          future: pokemonResponse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var listOfPokemon = snapshot.data.pokemonSummary;

              //ListView for Pokemon
              return PokemonListView(listOfPokemon: listOfPokemon);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ));
  }
}

class PokemonListView extends StatefulWidget {
  final listOfPokemon;
  const PokemonListView({Key key, @required this.listOfPokemon}) : super(key: key);

  @override
  State<PokemonListView> createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {

  int curOffset = 0;
  List<PokemonSummary> _pokemonSummary;

  @override
  void initState() {
    super.initState();
    _pokemonSummary = widget.listOfPokemon;
  }

  checkPokemon(context, url) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PokemonDetailsPage(url: url)),
    );
  }

  @override
  Widget build(BuildContext context){
    return NotificationListener<ScrollEndNotification>(
      child: ListView.builder(
        itemCount: _pokemonSummary.length,
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            child: ListTile(
              title: Text((index + 1).toString() + ". " + '${capitalize(widget.listOfPokemon[index].name)}'),
              onTap: (){ checkPokemon(context, widget.listOfPokemon[index].url); },
            ),
          );
        }
      ),
      onNotification: (notification){
        curOffset = curOffset + 20;
        PokemonApi().getPokemon(curOffset).then((res){
          setState(() {
            _pokemonSummary.addAll(res.pokemonSummary);
          });
        });
      },
    );
  }
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();