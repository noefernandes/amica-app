import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}
// Image.network('https://placedog.net/640/480?random'),
// Image.network('https://cataas.com/cat'),

class Menu {
  const Menu(this.name, this.icon);
  final String name;
  final String icon;
}

class _HomeState extends State<Home> {
  final filters = [
    const Menu('Cachorros', 'imagens/svg/dog.svg'),
    const Menu('Gatos', 'imagens/svg/cat.svg'),
    const Menu('Passáros', 'imagens/svg/bird.svg'),
    const Menu('Cobras', 'imagens/svg/snake.svg'),
  ];

  int active = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 4 + 30,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5,35,5,10),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          separatorBuilder: (context, _) => const SizedBox(width: 12),
          itemBuilder: (context, index) => buildMenu(index),
        ),
      ),
    );
  }

  Widget buildMenu(i) => SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      child: 
      ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(active == i ? Colors.white : Colors.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ))),
        onPressed: () {
          setState(() {
            active = i;
          });
        },
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: SvgPicture.asset(filters[i].icon, color: active != i ?  Colors.white : Colors.black),),
            Text(
              filters[i].name,
              style: TextStyle(color: active != i ?  Colors.white : Colors.black, fontSize: 14),
            )
          ],
        ),
      )
    );
}
