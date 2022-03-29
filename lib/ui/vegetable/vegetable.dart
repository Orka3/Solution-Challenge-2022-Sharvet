import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdscsolution/ui/vegetable/buyvegetable.dart';
import 'package:gdscsolution/ui/vegetable/sellveget.dart';
import 'package:provider/provider.dart';

import '../../model/login_model.dart';


class Veget extends StatefulWidget {


  @override
  _VegetState createState() => _VegetState();
}

class _VegetState extends State<Veget> {
  final r = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<FirebaseAuthService>().getData(r?.uid),
        builder: (BuildContext context,
        AsyncSnapshot<DocumentSnapshot> snapshot){
          if(!snapshot.hasData) return Container();
          final String? job = snapshot.data!['job'];
          print(job);
          if (job == "giver" || job=='farmer') {
            print(job);
            return Sellveget(job: job);
          } else {
            return Container();
          }

        });}

}
