import 'package:flutter/material.dart';
import 'package:amica/widgtes/insert_field_cadastro.dart';
import 'package:amica/widgtes/biography_text_field_cadastro.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class Pet {
  @required
  String name;
  @required
  String specie;
  String race;
  int age = 0;
  @required
  String sex;
  @required
  String contact;
  String biography;

  Pet(this.name, this.specie, this.race, this.age, this.sex, this.contact,
      this.biography);
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
  XFile? imageXFile;
  File? imageFile;

  Future<void> _openGallery(BuildContext context) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile = image;
      imageFile = File(imageXFile!.path);
    });
    Navigator.of(context).pop();
  }

  Future<void> _openCamera(BuildContext context) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      imageXFile = image;
      imageFile = File(imageXFile!.path);
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Forma de escolha da imagem"),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Galeria"),
                    onTap: () => _openGallery(context),
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  GestureDetector(
                    child: Text("Câmera"),
                    onTap: () => _openCamera(context),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _imageWidget() {
    if (imageFile == null) {
      return Container(
          padding: EdgeInsets.fromLTRB(0, 35, 0, 10),
          child: CircleAvatar(
            backgroundColor: Colors.white60,
            foregroundImage: AssetImage('imagens/dog.png'),
            radius: 90,
          ));
    } else {
      return Container(
          padding: EdgeInsets.fromLTRB(0, 35, 0, 10),
          child: CircleAvatar(
            foregroundImage: FileImage(imageFile!),
            radius: 90,
          ));
    }
  }

  void _savePet() {
    Pet pet = Pet(
        nameController.text,
        specieController.text,
        raceController.text,
        int.parse(ageController.text),
        sexController.text,
        contactController.text,
        biographyController.text);
    print(pet.name);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            _imageWidget(),
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
                onPressed: () => _showChoiceImage(context),
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
                  onPressed: _savePet,
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
