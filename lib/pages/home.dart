import 'package:amica/widgtes/card_pet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  const Menu(this.key, this.name, this.icon);
  final String key;
  final String name;
  final String icon;
}

class _HomeState extends State<Home> {
  final filters = [
    const Menu('dog ', 'Cachorros', 'imagens/svg/dog.svg'),
    const Menu('cat', 'Gatos', 'imagens/svg/cat.svg'),
    const Menu('bird', 'Passáros', 'imagens/svg/bird.svg'),
    const Menu('snake', 'Cobras', 'imagens/svg/snake.svg'),
  ];

  int active = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: SafeArea(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (context, _) => const SizedBox(width: 0),
              itemBuilder: (context, index) {
                Color cor = active == index
                    ? const Color(0Xffffffff)
                    : const Color(0xff4FA9A7);
                return buildMenu(index, cor);
              },
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 195,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, index) => Container(
                  child: CardPet(
                    snap: snapshot.data!.docs[index].data(),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget buildMenu(i, cor) => Padding(
        padding: const EdgeInsets.all(5),
        child: SizedBox(
            width: 100,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shadowColor: const Color(0xFFFF8C3B),
                backgroundColor:
                    active != i ? Colors.white : Colors.transparent,
                side: BorderSide(
                    width: 2,
                    color: active == i ? Colors.white : Colors.transparent),
              ),
              onPressed: () {
                setState(() {
                  active = i;
                });
                print(filters[i].key);
              },
              child: Column(
                children: [
                  Flexible(
                    child: Container(),
                    flex: 1,
                  ),
                  SizedBox(
                    height: 60,
                    child: SvgPicture.asset(
                      filters[i].icon,
                      color: cor,
                    ),
                  ),
                  Text(
                    filters[i].name,
                    style: TextStyle(color: cor, fontSize: 14),
                  ),
                  Flexible(
                    child: Container(),
                    flex: 1,
                  ),
                ],
              ),
            )),
      );
}
