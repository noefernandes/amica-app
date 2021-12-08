import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  const Favorite({ Key? key }) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Favorite Page',
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