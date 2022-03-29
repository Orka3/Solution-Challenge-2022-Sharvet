import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService with ChangeNotifier {
  FirebaseAuthService({auth}) : _auth = auth ?? FirebaseAuth.instance;

  FirebaseAuth _auth;

  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );


    final authResult = await _auth.signInWithCredential(credential);
    return authResult.user;
  }

  String _uid="uid";
  void getUID(String UID){
    _uid=UID;
  }
  String get uid =>_uid;

  String _job="job";
  void getJob(String Job){
    _job=Job;
  }
  String get job => _job;


  Future<DocumentSnapshot> getData(userid) async {
    var data= await FirebaseFirestore.instance.collection("users").doc(userid).get();

    return data;

  }
  Future<String> getrank(userid) async {
    var data= await FirebaseFirestore.instance.collection("users").doc(userid).get();
    final rank = data.data()!["rank"];
    return rank;
  }

  Future<int> getmile(userid) async {
    var data= await FirebaseFirestore.instance.collection("users").doc(userid).get();
    final mile = data.data()!["mileage"];
    return mile;
  }



}