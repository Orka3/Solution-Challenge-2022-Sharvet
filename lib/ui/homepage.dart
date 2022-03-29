import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdscsolution/ui/home/hompage1.dart';
import 'package:gdscsolution/ui/home/hompage2.dart';
import 'package:provider/provider.dart';

import '../model/login_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final r = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<FirebaseAuthService>().getData(r?.uid),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) return Container();
          final String? job = snapshot.data!['job'];
          print(job);
          if (job == "giver") {
            return HomePage1();
          } else if (job == "farmer") {
            return HomePage2();
          } else {
            return Container();
          }
        });
  }
}
