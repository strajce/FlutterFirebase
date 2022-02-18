import 'package:firebase_basic_example/services/auth.dart';
import 'package:firebase_basic_example/shared/constants.dart';
import 'package:firebase_basic_example/shared/loading.dart';
import 'package:firebase_basic_example/shared/string_extension.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _name = '';
  String _password = '';
  String _error = '';
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0,
              title: const Text('Sing up to Brew Crew'),
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
                        'Sing in',
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
                      setState(() => _email = value);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    onChanged: (value) {
                      setState(() => _name = value.capitalize());
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
                      setState(() => _password = value);
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
                          'Register',
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _loading = true);
                            dynamic result =
                                await _authService.registerWithEmailAndPassword(
                                    _email, _password, _name);
                            if (result == null) {
                              setState(() {
                                _loading = false;
                                _error = 'Please providi a valid email';
                              });
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
                    _error,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  )
                ]),
              ),
            ),
          );
  }
}
