import 'dart:ffi';
import 'dart:typed_data';

import 'package:amica/providers/user_provider.dart';
import 'package:amica/resources/firestore_methods.dart';
import 'package:amica/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:amica/widgtes/insert_field_cadastro.dart';
import 'package:amica/widgtes/biography_text_field_cadastro.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

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
  @required
  String sex;
  int age = 0;
  String race;
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
  Uint8List? _file;
  bool isLoading = false;

  Future<void> _openGallery(BuildContext context) async {
    Uint8List file = await pickImage(ImageSource.gallery);
    setState(() {
      _file = file;
    });
    Navigator.of(context).pop();
  }

  Future<void> _openCamera(BuildContext context) async {
    Uint8List file = await pickImage(ImageSource.camera);
    setState(() {
      _file = file;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Forma de escolha da imagem"),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: const Text("Galeria"),
                    onTap: () => _openGallery(context),
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  GestureDetector(
                    child: const Text("Câmera"),
                    onTap: () => _openCamera(context),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _imageWidget() {
    if (_file == null) {
      return Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: const CircleAvatar(
            backgroundColor: Colors.white60,
            foregroundImage: AssetImage('imagens/dog.png'),
            radius: 90,
          ));
    } else {
      return Container(
          padding: const EdgeInsets.fromLTRB(0, 35, 0, 10),
          child: CircleAvatar(
            foregroundImage: MemoryImage(_file!),
            radius: 90,
          ));
    }
  }

  void _savePet(String uid, String username) async {
    Pet pet = Pet(
        nameController.text,
        specieController.text,
        raceController.text,
        int.parse(ageController.text),
        sexController.text,
        contactController.text,
        biographyController.text);
    print(pet.name);

    setState(() {
      isLoading = true;
    });

    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        uid,
        username,
        nameController.text,
        specieController.text,
        sexController.text,
        int.parse(ageController.text),
        raceController.text,
        contactController.text,
        biographyController.text,
        _file!,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'Post realizado!',
        );
        clearImage();
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      nameController.clear();
      specieController.clear();
      raceController.clear();
      ageController.clear();
      sexController.clear();
      contactController.clear();
      biographyController.clear();
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 95,
      child: SingleChildScrollView(
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
                child: const Text(
                  "Alterar",
                  style: TextStyle(fontSize: 25),
                ),
              ),
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
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.redAccent),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.fromLTRB(30, 10, 30, 10)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  onPressed: () => _savePet(
                      userProvider.getUser.uid, userProvider.getUser.username),
                  child: !isLoading
                      ? const Text(
                          "Salvar",
                          style: TextStyle(fontSize: 25),
                        )
                      : const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
