import 'package:firebase_basic_example/models/user_model.dart';
import 'package:firebase_basic_example/screens/authenticate/authenticate.dart';
import 'package:firebase_basic_example/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    print(user);
    //Return home or login screne
    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }
    // const Authenticate();
  }
}
