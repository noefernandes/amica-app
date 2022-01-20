import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Cadastrar usuário
  Future<String> signUpUser(
      {required String email, required String password}) async {
    String res = "Ocorreu um erro";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        //Criando usuário
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);

        await _firestore.collection('users').doc(cred.user!.uid).set(
            {'email': email, 'password': password, 'bio': '', 'posts': []});

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
