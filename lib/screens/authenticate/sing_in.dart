import 'package:firebase_basic_example/services/auth.dart';
import 'package:firebase_basic_example/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_basic_example/shared/constants.dart';

class SingIn extends StatefulWidget {
  final Function toggleView;
  const SingIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  _SingInState createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0,
              title: const Text('Sing in to Brew Crew'),
              actions: [
                TextButton(
                  onPressed: () {
                    widget.toggleView();
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 48,
              ),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (value) =>
                        value!.isEmpty ? 'Enter an email' : null,
                    onChanged: (value) {
                      setState(() => email = value);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (value) => value!.length < 6
                        ? 'Enter a password at least 6 character long'
                        : null,
                    obscureText: true,
                    onChanged: (value) {
                      setState(() => password = value);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, bottom: 66),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.brown[400]),
                        ),
                        child: const Text(
                          'Sing in',
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _authService
                                .singInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(
                                () {
                                  loading = false;
                                  error =
                                      'Could not sing in with those credentials';
                                },
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  )
                ]),
              ),
            ),
          );
  }
}
