import 'package:firebase_basic_example/models/user_model.dart';
import 'package:firebase_basic_example/screens/wrapper.dart';
import 'package:firebase_basic_example/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // final database = openDatabase(
  //   onCreate: ((db, version) {
  //     return db.execute(
  //         'CREATE TABEL dog (id INTEGER PRIMARY KEY, name TEXT, age INTEGER');
  //   }),
  //   version: 1,
  // );
  // openDatabse(join(await getDatabasesPath(), 'coffee_database.db'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      initialData: null,
      child: const MaterialApp(
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
