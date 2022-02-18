import 'package:firebase_basic_example/models/user_model.dart';
import 'package:firebase_basic_example/services/firestore.dart';
import 'package:firebase_basic_example/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    //form values

    return StreamBuilder<UserData>(
      stream: FirestoreService(uid: user!.uuid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData? userData = snapshot.data;
          // _currentStrength = userData?.strength;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Update yout brew settings',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: userData!.name,
                  validator: (value) =>
                      value!.isEmpty ? 'Enter an email' : null,
                  onChanged: (value) {
                    setState(() => _currentName = value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButton(
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      child: Text('$sugar sugar(s)'),
                      value: sugar,
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _currentSugars = newValue!;
                    });
                  },
                ),
                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor:
                      Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[100],
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (value) => setState(
                    (() => _currentStrength = value.round()),
                  ),
                ),
                ElevatedButton(
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.brown[_currentStrength ?? userData.strength]),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await FirestoreService(uid: user.uuid).updateUserData(
                          _currentSugars ?? userData.sugars,
                          _currentName ?? userData.name,
                          _currentStrength ?? userData.strength);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}
