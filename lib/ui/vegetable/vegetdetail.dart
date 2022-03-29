import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/login_model.dart';

class VegetDetail extends StatefulWidget {
  var address, amount, contact, date, name, possible, ps, sort, uid, postid;

  VegetDetail(
      {this.address,
      this.amount,
      this.contact,
      this.date,
      this.name,
      this.possible,
      this.ps,
      this.sort,
      this.uid,
      this.postid});

  @override
  State<VegetDetail> createState() => _VegetDetailState(
      address: address,
      amount: amount,
      contact: contact,
      date: date,
      name: name,
      possible: possible,
      ps: ps,
      sort: sort,
      uid: uid,
  postid : postid);
}

class _VegetDetailState extends State<VegetDetail> {
  static Color mainColor = const Color(0xff00C776);
  final r = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  _VegetDetailState(
      {this.address,
      this.amount,
      this.contact,
      this.date,
      this.name,
      this.possible,
      this.ps,
      this.sort,
      this.uid,
      this.postid});

  var address, amount, contact, date, name, possible, ps, sort, uid,postid;

  @override
  Widget build(BuildContext context) {
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          Container(
              alignment: Alignment.topRight,
              child: r?.uid == uid
                  ? PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem<int>(
                          onTap: () {
                            firestore.collection('posting').doc(name).delete();
                          },
                          height: 30,
                          value: 0,
                          child: Text(
                            "delete",
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    )
                  : Container()),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 230,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 15, left: 15, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      name,
                      style: TextStyle(fontSize: 30, fontFamily: 'welcome'),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 15, bottom: 10),
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    date,
                    style: TextStyle(
                      fontFamily: 'welcome',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Vegetable list :',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'welcome',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          sort,
                          style: TextStyle(fontSize: 18, fontFamily: 'welcome'),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Vegetable total amount :',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'welcome',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          amount,
                          style: TextStyle(fontSize: 18, fontFamily: 'welcome'),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Delivery area :',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'welcome',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          possible,
                          style: TextStyle(fontSize: 18, fontFamily: 'welcome'),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '( p.s. $ps )',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[700],
                              fontFamily: 'welcome'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _reserve(address, amount, contact, date, name, possible, ps,
                      sort, uid, postid);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Resevation"),
                          actions: [
                            okButton,
                          ],
                          content:
                              Container(child: Text('Reservation Complete!')),
                        );
                      });
                },
                child: FutureBuilder(
                    future: context.read<FirebaseAuthService>().getData(r?.uid),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (!snapshot.hasData) return Container();
                      final String? job = snapshot.data!['job'];
                      if (job == 'farmer') {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              _reserve(address, amount, contact, date, name, possible, ps,
                                  sort, uid, postid);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Resevation"),
                                      actions: [
                                        okButton,
                                      ],
                                      content:
                                      Container(child: Text('Reservation Complete!')),
                                    );
                                  });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(5)),
                              padding: const EdgeInsets.all(8),
                              child: const Text(
                                'Make a reservation',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'welcome',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.all(15),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Giver Information',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'welcome',
                      color: Colors.grey[500]),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'address : $address',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'welcome',
                      color: Colors.grey[500]),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'contact : $contact',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'welcome',
                      color: Colors.grey[500]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _chars = 'AaBbCcDdEeFfGgHh';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  void _reserve(address, amount, contact, date, name, possible, ps, sort, uid,postid) {
    String postKey = getRandomString(8);
    firestore.collection('posting').doc(postid).update({'reservation': r?.uid});
    firestore.collection('reservation').doc(postKey).set(
      {
        'state': 'reserved',
        'farmeruid': r?.uid,
        'reservation': {
          'address': address,
          'amount': amount,
          'contact': contact,
          'date': date,
          'name': name,
          'possible': possible,
          'ps': ps,
          'giveruid': uid,
          'sort': sort
        },
        'postid' :postid,
        'postKey' :postKey
      },
    );
  }
}
