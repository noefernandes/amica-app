import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:amica/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Detalhes do usuario
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  //Cadastrar usuário
  Future<String> signUpUser(
      {required String username,
      required String email,
      required String password}) async {
    String res = "Ocorreu um erro";

    try {
      if (username.isNotEmpty || email.isNotEmpty || password.isNotEmpty) {
        //Criando usuário
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);

        model.User _user = model.User(
          username: username,
          email: email,
          password: password,
          uid: cred.user!.uid,
        );

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(_user.toJson());

        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  // logar usuario
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
