import 'package:firebase_basic_example/screens/home/icon.dart';
import 'package:firebase_basic_example/screens/settings/settings.dart';
import 'package:firebase_basic_example/services/auth.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  final AuthService _authService = AuthService();
  final String userName;
  HomeDrawer({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        SizedBox(
          height: 128,
          child: DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF8D6E63),
            ),
            child: Container(
              padding: const EdgeInsets.only(
                top: 16,
              ),
              child: Text(
                userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
        Builder(
          builder: (context) => Card(
            color: Colors.brown[50],
            elevation: 2,
            child: ListTile(
              title: const IconView(icon: Icons.settings, title: 'Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
              },
              onLongPress: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Settings',
                    ),
                  ),
                );
                Navigator.pop(context);
              },
            ),
          ),
        ),
        Card(
          color: Colors.brown[50],
          elevation: 2,
          child: ListTile(
            title: const IconView(
              icon: Icons.person,
              title: 'Log out',
            ),
            onTap: () async {
              await _authService.singOut();
            },
          ),
        ),
      ],
    );
  }
}
