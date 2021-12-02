import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: non_constant_identifier_names
  does_nothing() {}

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const Image(
        image: AssetImage('imagens/background.png'),
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Faça um novo amigo!",
                  style: GoogleFonts.baloo(
                      fontSize: 30.0,
                      color: const Color(0xffffffff),
                      decoration: TextDecoration.none),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Adote um pet hoje!",
                  style: GoogleFonts.baloo(                      
                      fontSize: 25.0,
                      color: const Color(0xff2E3359),
                      decoration: TextDecoration.none),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text(
                    "Let's go!",
                    style: GoogleFonts.baloo(
                      fontSize: 40.0, color: Colors.white
                    ),
                  ),
                  onPressed: () => does_nothing,
                ),
              ),
            ],
          ),
        ],
      ), //widget
    ]);
  }
}
