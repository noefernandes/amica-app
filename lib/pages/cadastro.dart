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
import 'package:amica/models/pet.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController nameController = TextEditingController();
  TextEditingController raceController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController biographyController = TextEditingController();
  Uint8List? _file;
  bool isLoading = false;
  String? specieDropdownValue;
  String? sexDropdownValue;

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
    if (_file == null) {
      Uint8List data =
          (await rootBundle.load('imagens/dog.png')).buffer.asUint8List();
      _file = data;
    }
    Pet pet = Pet(
        nameController.text,
        specieDropdownValue!,
        raceController.text,
        int.parse(ageController.text),
        sexDropdownValue!,
        contactController.text,
        biographyController.text,
        _file);

    setState(() {
      isLoading = true;
    });

    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        uid,
        username,
        pet.name,
        pet.specie,
        pet.sex,
        pet.age,
        pet.race,
        pet.contact,
        pet.biography,
        pet.photo!,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'Posted!',
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
      specieDropdownValue = null;
      raceController.clear();
      ageController.clear();
      sexDropdownValue = null;
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
                      child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(11, 5, 11, 5),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                          child: const Text(
                            'Espécie',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                                alignment: Alignment.center,
                                value: specieDropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style: const TextStyle(
                                  color: Colors.black,
                                  backgroundColor: Colors.white,
                                ),
                                dropdownColor: Colors.white,
                                iconEnabledColor: Colors.redAccent,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    specieDropdownValue = newValue!;
                                  });
                                },
                                isDense: true,
                                items: const <DropdownMenuItem<String>>[
                                  DropdownMenuItem(
                                      child: Text('Cachorro'), value: 'dog'),
                                  DropdownMenuItem(
                                      child: Text('Gato'), value: 'cat'),
                                  DropdownMenuItem(
                                      child: Text('Pássaro'), value: 'bird'),
                                  DropdownMenuItem(
                                      child: Text('Cobra'), value: 'snake'),
                                ]),
                          )),
                        )
                      ],
                    ),
                  ))
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
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(11, 5, 11, 5),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                                child: const Text(
                                  'Sexo',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButton<String>(
                                          alignment: Alignment.center,
                                          value: sexDropdownValue,
                                          icon:
                                              const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            backgroundColor: Colors.white,
                                          ),
                                          dropdownColor: Colors.white,
                                          iconEnabledColor: Colors.redAccent,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              sexDropdownValue = newValue!;
                                            });
                                          },
                                          isDense: true,
                                          items: const <
                                              DropdownMenuItem<String>>[
                                            DropdownMenuItem(
                                              child: Text('Macho'),
                                              value: 'M',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Fêmea'),
                                              value: 'F',
                                            )
                                          ],
                                        )),
                                  ))
                            ],
                          ))),
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
