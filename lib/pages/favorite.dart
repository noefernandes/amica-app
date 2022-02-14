import 'package:amica/providers/user_provider.dart';
import 'package:amica/widgtes/card_pet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(
            height: 100,
            child: Padding(
                padding: EdgeInsets.all(25),
                child: Text(
                  'Favoritos',
                  style: GoogleFonts.baloo(
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                      fontSize: 35),
                ))),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 195,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .where('favorites', arrayContains: userProvider.getUser.uid)
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
                itemBuilder: (ctx, index) => Container(
                  child: CardPet(
                    snap: snapshot.data!.docs[index].data(),
                  ),
                ),
              );
            },
          ),
        )
      ],
    ));
  }
}
