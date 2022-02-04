import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:amica/models/post.dart';
import 'package:amica/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
      String uid,
      String username,
      String name,
      String specie,
      String sex,
      int age,
      String race,
      String contact,
      String biography,
      Uint8List file) async {
    String res = "Some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1(); // creates unique id based on time
      Post post = Post(
          uid: uid,
          username: username,
          name: name,
          postId: postId,
          specie: specie,
          sex: sex,
          age: age,
          race: race,
          contact: contact,
          biography: biography,
          postUrl: photoUrl);
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete Post
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
