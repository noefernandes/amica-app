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

        res = 'Sucesso';
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
