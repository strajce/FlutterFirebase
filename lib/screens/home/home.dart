import 'package:firebase_basic_example/models/brew_model.dart';
import 'package:firebase_basic_example/screens/home/brew_list.dart';
import 'package:firebase_basic_example/screens/home/icon.dart';
import 'package:firebase_basic_example/screens/home/settings_form.dart';
import 'package:firebase_basic_example/screens/settings/settings.dart';
import 'package:firebase_basic_example/services/auth.dart';
import 'package:firebase_basic_example/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();
  final String userName;
  Home({Key? key, required this.userName}) : super(key: key);

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
              onPressed: () => _showSettingsPanel(),
              child: Row(
                children: const [
                  Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.brown[50],
          child: ListView(
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
                    title:
                        const IconView(icon: Icons.settings, title: 'Settings'),
                    onTap: () {
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
          ),
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
