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
            height: MediaQuery.of(context).size.height
          ),
          color: const Color(0xff4FA9A7),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height*-0.7,
          left: MediaQuery.of(context).size.width*-0.3,
          child: Transform.rotate(
            angle: 3.14/4,
            child: Container(
              constraints: BoxConstraints.tightForFinite(
                width: MediaQuery.of(context).size.width*1.5,
                height: MediaQuery.of(context).size.height*1
              ),
              decoration: BoxDecoration(
                color: const Color(0X66FFFFFF),
                borderRadius: BorderRadius.circular(120),
              ),
              alignment: Alignment.center,

            ),
          )
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height*-.3,
          left: MediaQuery.of(context).size.width*-.30,
          child: Container(
            constraints: BoxConstraints.tightForFinite(
              width: MediaQuery.of(context).size.height,
              height: MediaQuery.of(context).size.height
            ),
            alignment: Alignment.center,
            child: Transform.scale(
              scale: .8,
              child: Image.asset('imagens/dog.png'),
            ),
          ),
        ),
        Scaffold(
            backgroundColor: const Color(0x004FA9A7),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,70,0,0),
                  child: SvgPicture.asset('imagens/logo.svg', color: Colors.white),
                ),
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
            )))
      ],
    );
  }
}
