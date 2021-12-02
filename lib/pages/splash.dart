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

    Timer(const Duration(seconds: 5), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff4FA9A7),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset('imagens/logo.svg', color: Colors.white),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                'Amica',
                style: GoogleFonts.aclonica(
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                    fontSize: 50),
              ),
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
                style: GoogleFonts.athiti(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF2E3359),
                    fontSize: 20),
              ),
            ),
          ],
        )));
  }
}
