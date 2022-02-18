import 'package:firebase_basic_example/models/brew_model.dart';
import 'package:firebase_basic_example/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final List<BrewModel> brews = Provider.of<List<BrewModel>>(context);
    // print('Brew document : ${brews.docs}');
    return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (BuildContext context, int index) {
          return BrewTile(brew: brews[index]);
        });
  }
}
