import 'package:amica/pages/favorite.dart';
import 'package:amica/pages/person.dart';
import 'package:amica/pages/cadastro.dart';
import 'package:amica/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUser();
  }

  int index = 0;

  final pages = [
    const Home(),
    const Favorite(),
    const Cadastro(),
    const Person()
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.home, size: 30),
      const Icon(Icons.favorite, size: 30),
      const Icon(Icons.assignment, size: 30),
      const Icon(Icons.person, size: 30),
    ];

    return Scaffold(
      extendBody: false,
      backgroundColor: const Color(0xff4FA9A7),
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.black87)),
        child: CurvedNavigationBar(
          height: 55,
          index: index,
          items: items,
          backgroundColor: Colors.transparent,
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
      body: SafeArea(
        child: pages[index],
      ),
    );
  }
}
