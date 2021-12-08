import 'package:flutter/material.dart';

class Person extends StatefulWidget {
  const Person({ Key? key }) : super(key: key);

  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Person Page',
        style: TextStyle(
          color: Colors.white,
          fontSize: 100,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}