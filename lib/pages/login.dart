import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String _textInfo = "";

  void _entrar() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff4FA9A7),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SvgPicture.asset('imagens/logo.svg', color: Colors.white),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 15.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Nome do usuário",
                        labelStyle: TextStyle(color: Colors.grey[600])),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 25.0),
                    controller: usernameController,
                    validator: (value) {
                      if (value!.isEmpty)
                        return "Insira o seu nome de usuário!";
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Senha",
                        labelStyle: TextStyle(color: Colors.grey[600])),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 25.0),
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) return "Insira sua senha!";
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(70.0, 15.0, 70.0, 15.0),
                  child: ButtonTheme(
                      height: 50.0,
                      highlightColor: Colors.amber,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.redAccent),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    const EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0)),
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                        side: const BorderSide(
                                            color: Colors.redAccent)))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) _entrar();
                        },
                        child: const Text(
                          "Entrar",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                      )),
                ),
                Text(
                  _textInfo,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 25.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
