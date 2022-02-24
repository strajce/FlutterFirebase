import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: const Text(
          'Settings Screen',
        ),
        backgroundColor: Colors.brown[400],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/coffee_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Text(
          'Welcome to the settings screne',
        ),
      ),
    );
  }
}
