import 'package:amica/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:amica/resources/auth_methods.dart';

class Person extends StatefulWidget {
  const Person({Key? key}) : super(key: key);

  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    void _sair() async {
      await AuthMethods().signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }

    return Center(
      child: ElevatedButton(
        child: const Text("Log out"),
        onPressed: _sair,
      ),
    );
  }
}
