import 'package:flutter/material.dart';
import 'package:amica/widgtes/insert_field_cadastro.dart';
import 'package:amica/widgtes/biography_text_field_cadastro.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController nameController = TextEditingController();
  TextEditingController specieController = TextEditingController();
  TextEditingController raceController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController biographyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String _textInfo = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 35, 0, 10),
              child: CircleAvatar(
                backgroundImage: AssetImage('imagens/dog.png'),
                radius: 90,
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.fromLTRB(30, 10, 30, 10)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(color: Colors.grey)))),
                onPressed: () => print("alterado"),
                child: Text(
                  "Alterar",
                  style: TextStyle(fontSize: 25),
                )),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: InsertFieldCadastro(
                      textEditingController: nameController,
                      fieldName: "Nome",
                      textInputType: TextInputType.name),
                ),
                Expanded(
                  child: InsertFieldCadastro(
                      textEditingController: specieController,
                      fieldName: "Espécie",
                      textInputType: TextInputType.text),
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: InsertFieldCadastro(
                      textEditingController: raceController,
                      fieldName: "Raça",
                      textInputType: TextInputType.text),
                ),
                Expanded(
                  child: InsertFieldCadastro(
                      textEditingController: ageController,
                      fieldName: "Idade",
                      textInputType: TextInputType.number),
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: InsertFieldCadastro(
                      textEditingController: sexController,
                      fieldName: "Sexo",
                      textInputType: TextInputType.text),
                ),
                Expanded(
                  child: InsertFieldCadastro(
                      textEditingController: contactController,
                      fieldName: "Contato",
                      textInputType: TextInputType.phone),
                )
              ],
            ),
            BiographyTextField(
              textEditingController: biographyController,
              fieldName: "Biografia",
              textInputType: TextInputType.text,
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.redAccent),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.fromLTRB(30, 10, 30, 10)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side:
                                  const BorderSide(color: Colors.redAccent)))),
                  onPressed: () => print("salvar"),
                  child: Text(
                    "Salvar",
                    style: TextStyle(fontSize: 25),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
