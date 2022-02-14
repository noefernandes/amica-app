import 'package:amica/pages/login.dart';
import 'package:amica/providers/user_provider.dart';
import 'package:amica/resources/firestore_methods.dart';
import 'package:amica/widgtes/card_pet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:amica/resources/auth_methods.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class Person extends StatefulWidget {
  const Person({Key? key}) : super(key: key);

  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    void _sair() async {
      await AuthMethods().signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }

    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(
            height: 100,
            child: Padding(
                padding: EdgeInsets.all(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Olá, ' + userProvider.getUser.username + '!',
                      style: GoogleFonts.baloo(
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          fontSize: 27),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: ElevatedButton(
                        child: const Text(
                          "Sair",
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  const EdgeInsets.fromLTRB(30, 10, 30, 10)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(color: Colors.redAccent),
                            ),
                          ),
                        ),
                        onPressed: _sair,
                      ),
                    )
                  ],
                ))),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 195,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .where('uid', isEqualTo: userProvider.getUser.uid)
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (ctx, index) => Dismissible(
                        background: Container(
                          color: Colors.red,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        key: UniqueKey(),
                        onDismissed: (DismissDirection direction) async {
                          await FireStoreMethods().deletePost(
                              snapshot.data!.docs[index].data()['postId']);
                        },
                        child: Container(
                          child: CardPet(
                            snapshot.data!.docs[index].data(),
                          ),
                        ),
                      ));
            },
          ),
        )
      ],
    ));
  }
}
