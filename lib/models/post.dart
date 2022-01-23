import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String uid; //Id do doador
  final String username; //Nome do doador
  final String name; //Nome do animal
  final String postId;
  final String specie;
  final String sex;
  final String contact;
  final String biography;
  final String postUrl;

  const Post(
      {required this.uid,
      required this.username,
      required this.name,
      required this.postId,
      required this.specie,
      required this.sex,
      required this.contact,
      required this.biography,
      required this.postUrl});

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        uid: snapshot["uid"],
        username: snapshot["username"],
        name: snapshot["name"],
        postId: snapshot["postId"],
        specie: snapshot["specie"],
        sex: snapshot["sex"],
        contact: snapshot["contact"],
        biography: snapshot["biography"],
        postUrl: snapshot['postUrl']);
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "name": name,
        "postId": postId,
        "specie": specie,
        "sex": sex,
        "contact": contact,
        "biography": biography,
        "postUrl": postUrl
      };
}
