import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class CardInfo extends StatefulWidget {
  const CardInfo({Key? key}) : super(key: key);

  @override
  _CardInfoState createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  bool isLiked = false;
  bool hasBackground = false;
  final key = GlobalKey<LikeButtonState>();

  @override
  Widget build(BuildContext context) {
    const double size = 50;
    const aimationDuration = Duration(milliseconds: 500);

    return Scaffold(
        appBar: AppBar(
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
                tag: 'image',
                child: Image.network(
                  'https://placeimg.com/640/680/any',
                  width: MediaQuery.of(context).size.width * 0.4 - 5,
                  alignment: Alignment.center,
                  fit: BoxFit.fitWidth,
                  height: 250,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: BorderSide(width: 1, color: hasBackground ? Colors.red : Colors.grey),
                      backgroundColor:
                          hasBackground ? Colors.red : Colors.white,
                      fixedSize: const Size.fromWidth(180),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    ),
                    onPressed: () async {
                      setState(() => hasBackground = !isLiked);
                      await Future.delayed(const Duration(milliseconds: 100));
                      key.currentState!.onTap();
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
                                Future.delayed(aimationDuration).then(
                                    (_) => setState(() => hasBackground = !isLiked));
                                return !isLiked;
                              },
                            ),
                          ),
                          Text(
                            'Favoritar',
                            style: TextStyle(
                                fontSize: 22,
                                color: hasBackground
                                    ? Colors.white
                                    : Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
