import 'dart:typed_data';
import 'package:flutter/material.dart';

class Pet {
  @required
  String name;
  @required
  String specie;
  @required
  String sex;
  @required
  String contact;
  String biography;
  String race;
  int age = 0;
  Uint8List? photo;

  Pet(this.name, this.specie, this.race, this.age, this.sex, this.contact,
      this.biography, this.photo);
}
