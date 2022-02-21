import 'package:firebase_basic_example/models/brew_model.dart';
import 'package:firebase_basic_example/screens/home/brew_list.dart';
import 'package:firebase_basic_example/screens/home/icon.dart';
import 'package:firebase_basic_example/screens/home/settings_form.dart';
import 'package:firebase_basic_example/services/auth.dart';
import 'package:firebase_basic_example/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: const SettingsForm(),
            );
          });
    }

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
          actions: <Widget>[
            TextButton(
              // style: ButtonStyle(
              //     backgroundColor:
              //         MaterialStateProperty.all(Colors.brown[400])),
              onPressed: () async {
                await _authService.singOut();
              },
              child: const IconView(icon: Icons.person, title: 'Log out'),
            ),
            TextButton(
              onPressed: () => _showSettingsPanel(),
              child: const IconView(icon: Icons.settings, title: 'Settings'),
            )
          ],
        ),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: const BrewList()),
      ),
    );
  }
}
