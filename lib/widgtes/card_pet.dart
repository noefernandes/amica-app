import 'package:flutter/material.dart';

import 'card_info.dart';

class CardPet extends StatelessWidget {
  final snap;
  const CardPet({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardInfo(snap: snap),
          ),
        );
      },
      child: Card(
        semanticContainer: true,
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6 - 5,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(snap['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25)),
                    Text('Idade: ' + snap['age'].toString() + ' anos',
                        style: TextStyle(fontSize: 18)),
                    Text('Raça: ' + snap['race'],
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
            Hero(
              tag: 'image' + snap['postId'],
              child: Image.network(
                snap['postUrl'],
                width: MediaQuery.of(context).size.width * 0.4 - 5,
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth,
                height: 100,
              ),
            )
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        margin: const EdgeInsets.all(5),
      ),
    );
  }
}
