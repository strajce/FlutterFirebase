import 'package:firebase_basic_example/screens/authenticate/register.dart';
import 'package:firebase_basic_example/screens/authenticate/sing_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isSignedIn = true;
  void toggleView() {
    setState(() {
      isSignedIn = !isSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return SingIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
