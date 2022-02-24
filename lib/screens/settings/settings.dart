import 'package:firebase_basic_example/database/database_helper.dart';
import 'package:firebase_basic_example/models/test_model.dart';
import 'package:firebase_basic_example/screens/settings/settings_form.dart';
import 'package:firebase_basic_example/shared/loading.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final textController = TextEditingController();
  int? selectedId;

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
        child: ListView(
          children: [
            SizedBox(
              height: 60,
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: const Color.fromARGB(0, 215, 204, 200),
                elevation: 4,
                child: ListTile(
                  title: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'SETTINGS FORM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () => _showSettingsPanel(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              child: TextField(
                controller: textController,
              ),
            ),
            SizedBox(
              height: double.maxFinite,
              child: FutureBuilder<List<TestModel>>(
                future: DatabaseHelper.instance.getGroceries(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Loading(),
                    );
                  }
                  return snapshot.data!.isEmpty
                      ? const Center(
                          child: Text(
                            'No Groceries in List',
                          ),
                        )
                      : ListView(
                          children: snapshot.data!.map((grocery) {
                            return Center(
                              child: ListTile(
                                onLongPress: () {
                                  setState(() {
                                    DatabaseHelper.instance.remove(grocery.id!);
                                  });
                                },
                                title: Text(
                                  grocery.name,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                onTap: () {
                                  setState(
                                    () {
                                      if (selectedId == null) {
                                        textController.text = grocery.name;
                                        selectedId = grocery.id;
                                      } else {
                                        textController.text = '';
                                        selectedId = null;
                                      }
                                    },
                                  );
                                },
                              ),
                            );
                          }).toList(),
                        );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown[400],
        child: const Icon(
          Icons.save,
        ),
        onPressed: () async {
          selectedId != null
              ? await DatabaseHelper.instance
                  .update(TestModel(name: textController.text, id: selectedId))
              : await DatabaseHelper.instance
                  .add(TestModel(name: textController.text));
          setState(() {
            textController.clear();
            selectedId = null;
          });
        },
      ),
    );
  }
}
