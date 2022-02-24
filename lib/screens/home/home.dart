import 'package:firebase_basic_example/models/brew_model.dart';
import 'package:firebase_basic_example/screens/home/brew_list.dart';
import 'package:firebase_basic_example/screens/home/home_drawer.dart';
// import 'package:firebase_basic_example/services/auth.dart';
import 'package:firebase_basic_example/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  // final AuthService _authService = AuthService();
  final String userName;
  const Home({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<BrewModel>>.value(
      value: FirestoreService.withoutUid().brews,
      initialData: const [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text(
            'Brew Crew',
          ),
          backgroundColor: Colors.brown[400],
          elevation: 0,
        ),
        drawer: Drawer(
          backgroundColor: Colors.brown[50],
          child: HomeDrawer(userName: userName),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: const BrewList(),
        ),
      ),
    );
  }
}
