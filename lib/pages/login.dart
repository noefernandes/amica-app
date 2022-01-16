import 'package:amica/pages/signup.dart';
import 'package:amica/widgtes/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _entrar() {
    setState(() {});
  }

  void _goToSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Signup()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff4FA9A7),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(
                      height: 24,
                    ),
                    Column(
                      children: <Widget>[
                    SizedBox(
                      child: SvgPicture.asset('imagens/logo.svg',
                          color: Colors.white),
                      height: MediaQuery.of(context).size.width * .15,
                    ),
                      Text(
                        'Amica',
                        style: GoogleFonts.aclonica(
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                            fontSize: 50),
                      ),
                    ]),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFielInput(
                      hintText: 'Email',
                      textInputType: TextInputType.emailAddress,
                      textEditingController: usernameController,
                      icon: const Icon(Icons.email),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFielInput(
                      hintText: 'Senha',
                      textInputType: TextInputType.emailAddress,
                      textEditingController: passwordController,
                      icon: const Icon(Icons.lock),
                      isPass: true,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  const EdgeInsets.all(15.0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: const BorderSide(
                                          color: Colors.redAccent)))),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) _entrar();
                      },
                      child: const Text(
                        "Entrar",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ButtonTheme(
                      height: 50.0,
                      highlightColor: Colors.amber,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    const EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side:
                                        const BorderSide(color: Colors.white)))),
                        onPressed: () {
                          _goToSignUp();
                        },
                        child: const Text(
                          "Criar nova conta",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
