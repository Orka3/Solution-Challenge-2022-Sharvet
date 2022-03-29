import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdscsolution/ui/reservation/giverreservation.dart';
import 'package:provider/provider.dart';

import '../../model/login_model.dart';
import 'farmerreservation.dart';

class Reservation extends StatefulWidget {
  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  final r = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: context.read<FirebaseAuthService>().getData(r?.uid),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) return Container();
            final String? job = snapshot.data!['job'];
            print(job);
            if (job == "giver") {
              return giverReservation();
            } else if (job == "farmer") {
              return farmerReservation();
            } else{
              return Container();
            }
          }),
    );
  }
}
