import 'package:amica/pages/favorite.dart';
import 'package:amica/pages/login.dart';
import 'package:amica/pages/person.dart';
import 'package:amica/pages/settings.dart';
import 'package:amica/resources/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'home.dart';


class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int index = 0;

  final pages = [
    const Home(),
    const Favorite(),
    const Settings(),
    const Person()
  ];

  @override
  Widget build(BuildContext context) {
    void _sair() async {
      await AuthMethods().signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }
    final items = <Widget>[
      const Icon(Icons.home, size:30),
      const Icon(Icons.favorite, size:30),
      const Icon(Icons.settings, size:30),
      const Icon(Icons.person, size:30),
    ];

    return Scaffold(
      extendBody: false,
      backgroundColor: const Color(0xff4FA9A7),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.black87)
        ),
        child: CurvedNavigationBar(
          height: 55,
          index: index,
          items: items,
          backgroundColor: Colors.transparent,
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
      body: Column(
        children: [
          SafeArea( child: Column(
            children: [
              ElevatedButton(
                child: Text("Log out"),
                onPressed: _sair,
              ),
              pages[index],
            ],
          ),),
        ],
      ),
     );
  }
}
