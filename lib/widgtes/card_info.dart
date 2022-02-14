import 'package:amica/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class CardInfo extends StatefulWidget {
  final snap;
  const CardInfo({Key? key, required this.snap}) : super(key: key);
  @override
  _CardInfoState createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  bool isLiked = false;
  bool hasBackground = false;
  final key = GlobalKey<LikeButtonState>();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    const double size = 30;
    const aimationDuration = Duration(milliseconds: 500);

    hasBackground = widget.snap['favorites'].contains(userProvider.getUser.uid);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff4FA9A7),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Hero(
                tag: 'image' + widget.snap['postId'],
                child: Image.network(
                  widget.snap['postUrl'],
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                  height: 250,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Botão Favorito
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: BorderSide(
                          width: 1,
                          color: hasBackground ? Colors.red : Colors.grey),
                      backgroundColor:
                          hasBackground ? Colors.red : Colors.white,
                      fixedSize: const Size.fromWidth(180),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                    ),
                    onPressed: () async {
                      setState(() => hasBackground = !isLiked);
                      await Future.delayed(const Duration(milliseconds: 100));
                      key.currentState!.onTap();
                      if (isLiked && hasBackground == false) {
                        List newFavorites = widget.snap['favorites'];
                        newFavorites.add(userProvider.getUser.uid);
                        FirebaseFirestore.instance
                            .collection('posts')
                            .doc(widget.snap['postId'])
                            .update({'favorites': newFavorites});

                        print(newFavorites);
                      } else {
                        List newFavorites = widget.snap['favorites'];
                        newFavorites.remove(userProvider.getUser.uid);
                        FirebaseFirestore.instance
                            .collection('posts')
                            .doc(widget.snap['postId'])
                            .update({'favorites': newFavorites});

                        print(newFavorites);
                      }
                      /*List newFavorites = widget.snap['favorites'];
                      newFavorites.add(userProvider.getUser.uid);
                      await widget.snap['postId']
                          .update({"favorites": newFavorites})
                          .whenComplete(
                              () => print("Note item updated in the database"))
                          .catchError((e) => print(e));*/
                    },
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IgnorePointer(
                            child: LikeButton(
                              key: key,
                              size: size,
                              isLiked: isLiked,
                              likeBuilder: (isLiked) {
                                final color =
                                    isLiked ? Colors.white : Colors.grey;
                                return Icon(
                                  Icons.favorite,
                                  color: color,
                                  size: size,
                                );
                              },
                              circleColor: const CircleColor(
                                start: Colors.green,
                                end: Colors.blueAccent,
                              ),
                              bubblesColor: const BubblesColor(
                                dotPrimaryColor: Colors.green,
                                dotSecondaryColor: Colors.greenAccent,
                              ),
                              animationDuration: aimationDuration,
                              likeCountPadding: const EdgeInsets.only(left: 5),
                              onTap: (isLiked) async {
                                this.isLiked = !isLiked;
                                Future.delayed(aimationDuration).then((_) =>
                                    setState(() => hasBackground = !isLiked));
                                return !isLiked;
                              },
                            ),
                          ),
                          Text(
                            'Favoritar',
                            style: TextStyle(
                                fontSize: 22,
                                color:
                                    hasBackground ? Colors.white : Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Fim botão favorito
                  // Botão Contato
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: BorderSide(width: 1, color: Color(0xff4FA9A7)),
                      backgroundColor: Color(0xff4FA9A7),
                      fixedSize: const Size.fromWidth(180),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                    ),
                    onPressed: () {
                      //print('irá abrir o telefone ja com o número do contato');
                      UrlLauncher.launch('tel:+${widget.snap['contact']}');
                    },
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Contato',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Fim botão contato
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  widget.snap['biography'],
                  style: TextStyle(fontSize: 22),
                  textAlign: TextAlign.justify,
                ),
              ),
            )
          ],
        ));
  }
}
