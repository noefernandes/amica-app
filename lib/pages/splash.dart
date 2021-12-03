import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    // Timer(const Duration(seconds: 150), () {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => Login(),
    //       ));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          constraints: BoxConstraints.tightForFinite(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height),
          color: const Color(0xff4FA9A7),
        ),
        PositionedDirectional(
          bottom: -150,
          end: 0,
          child: SizedBox(
            child: Transform.rotate(
              angle: 3.14 / 4,
              child: Container(
                constraints: BoxConstraints.tightForFinite(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width),
                decoration: const BoxDecoration(
                  color: Color(0X3FFFFFFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(220),
                  ),
                ),
              ),
            ),
          ),
        ),
        PositionedDirectional(
          bottom: 0,
          end: MediaQuery.of(context).size.width * .25,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: Image.asset('imagens/dog.png'),
          ),
        ),
        Scaffold(
            backgroundColor: const Color(0x004FA9A7),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                    child: SizedBox(
                        height: MediaQuery.of(context).size.width * .15,
                        child: SvgPicture.asset('imagens/logo.svg',
                            color: Colors.white))),
                Text(
                  'Amica',
                  style: GoogleFonts.aclonica(
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                      fontSize: 50),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    'Faça um novo amigo!',
                    style: GoogleFonts.baloo(
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    'Adote um pet hoje',
                    style: GoogleFonts.aBeeZee(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF2E3359),
                        fontSize: 20),
                  ),
                ),
              ],
            )))
      ],
    );
  }
}
