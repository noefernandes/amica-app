import 'package:amica/pages/home.dart';
import 'package:amica/pages/temp.dart';
import 'package:amica/resources/auth_methods.dart';
import 'package:amica/utils/utils.dart';
import 'package:amica/widgtes/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  TextEditingController speciesController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String _textInfo = "";
  bool _isLoading = false;

  Future<void> _entrar() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
        email: emailController.text, password: passwordController.text);

    if (res == "success") {
      setState(() {
        _isLoading = false;
      });

      print("Redirecionando");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Temp()),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Cadastre-se",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color(0xff4FA9A7)),
      backgroundColor: const Color(0xff4FA9A7),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(children: <Widget>[
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
                  hintText: 'Nome Completo',
                  textInputType: TextInputType.name,
                  textEditingController: nameController,
                  icon: const Icon(Icons.person),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFielInput(
                  hintText: 'Email',
                  textInputType: TextInputType.name,
                  textEditingController: emailController,
                  icon: const Icon(Icons.email),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFielInput(
                    hintText: 'Senha',
                    textInputType: TextInputType.name,
                    textEditingController: passwordController,
                    icon: const Icon(Icons.password),
                    isPass: true),
                const SizedBox(
                  height: 24,
                ),
                TextFielInput(
                    hintText: 'Repita a Senha',
                    textInputType: TextInputType.name,
                    textEditingController: repeatPasswordController,
                    icon: const Icon(Icons.password),
                    isPass: true),
                const SizedBox(
                  height: 24,
                ),
                ButtonTheme(
                    height: 50.0,
                    highlightColor: Colors.amber,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.fromLTRB(
                                  20.0, 15.0, 20.0, 15.0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: const BorderSide(
                                          color: Colors.redAccent)))),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) _entrar();
                      },
                      child: !_isLoading
                          ? const Text(
                              "Criar",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25.0),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                    )),
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
