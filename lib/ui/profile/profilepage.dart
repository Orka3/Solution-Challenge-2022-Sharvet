import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdscsolution/ui/profile/profilefarmer.dart';
import 'package:gdscsolution/ui/profile/profilegiver.dart';
import 'package:provider/provider.dart';

import '../../model/login_model.dart';
import '../reservation/newReservation.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
            return Profileg();
          } else if (job == "farmer") {
            return Profilef();
          } else {
            return Container();
          }
        });
  }
}