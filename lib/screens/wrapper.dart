import 'package:firebase_basic_example/models/user_model.dart';
import 'package:firebase_basic_example/screens/authenticate/authenticate.dart';
import 'package:firebase_basic_example/screens/home/home.dart';
import 'package:firebase_basic_example/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    //Return home or login screne
    if (user == null) {
      return const Authenticate();
    } else {
      return StreamBuilder<UserData>(
          stream: FirestoreService(uid: user.uuid).userData,
          builder: (context, snapshot) {
            UserData? userData = snapshot.data;
            return Home(userName: userData?.name ?? '');
          });
    }
  }
}
