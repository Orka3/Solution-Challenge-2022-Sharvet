import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdscsolution/ui/information/farmerinfo.dart';
import 'package:gdscsolution/ui/reservation/reservationpage.dart';
import 'dart:math';

import 'package:gdscsolution/ui/vegetable/vegetable.dart';
import 'package:provider/provider.dart';

import '../../model/login_model.dart';

class HomePage2 extends StatefulWidget {
  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<HomePage2> {
  var randomNumber = Random().nextInt(1);
  List akf = ['Healthy feed for pigs!', 'A step for our next generation!'];
  final r = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: context.watch<FirebaseAuthService>().getData(r?.uid),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return Scaffold(
              backgroundColor: Colors.green[50],
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading:  IconButton(
                    onPressed: () {
                      Navigator.pop(context); //뒤로가기
                    },
                    color: Colors.white,
                    icon: Icon(Icons.arrow_back)),
              ),
              endDrawer: Drawer(
                child: ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      currentAccountPicture: const CircleAvatar(
                        backgroundImage: AssetImage('assets/image/account.png'),
                        backgroundColor: Colors.white,
                      ),
                      otherAccountsPictures: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/image/farmer.png'),
                          backgroundColor: Colors.white,
                        ),
                      ],
                      accountName: Text(
                        snapshot.data!['bname'], style: TextStyle(fontSize: 20),),
                      accountEmail: Text(snapshot.data!['name'],
                        style: TextStyle(fontSize: 15),),
                      onDetailsPressed: () {
                        print('arrow is clicked.');
                      },
                      decoration: BoxDecoration(
                          color: Color(0xff79d2a6),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0))),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.home,
                        color: Colors.grey,
                      ),
                      title: Text('Home'),
                      onTap: () {
                        print('Home is clicked.');
                      },
                      trailing: Icon(Icons.add),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.settings,
                        color: Colors.grey,
                      ),
                      title: Text('Setting'),
                      onTap: () {
                        print('Setting is clicked.');
                      },
                      trailing: Icon(Icons.add),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.question_answer,
                        color: Colors.grey,
                      ),
                      title: Text('Q&A'),
                      onTap: () {
                        print('Q&A is clicked.');
                      },
                      trailing: Icon(Icons.add),
                    )
                  ],
                ),
              ),
              extendBodyBehindAppBar: true,
              body: Column(children: [
                Container(
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * .32,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  // Add one stop for each color. Stops should increase from 0 to 1
                                  stops: [0.2, 0.7],
                                  colors: [
                                    Color(0xff00b2bb),
                                    Color(0xff79d2a6),
//                        Colors.blue[400],
//                        Colors.blue[300],
                                  ],
                                  // stops: [0.0, 0.1],
                                ),
                              ),
                              padding: EdgeInsets.only(top: 40, left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${akf[randomNumber]} \nYou saved our planet!",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'font3',
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    child: Image.asset(
                                        'assets/image/pigpig.png',
                                        width: 150, height: 300),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => Veget()));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/image/vegetable.png',
                                        width: 100,
                                      ),
                                      SizedBox(width: 25),
                                      Text('Buy Vegetables',
                                          style: TextStyle(
                                              fontFamily: 'font3',
                                              fontSize: 25)),
                                    ],
                                  ),
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  height: 150,
                                ),
                              ),
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) =>
                                            Reservation()));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            15)),
                                    child: Container(
                                      height: 150,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.45,
                                      child: Center(
                                        child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                  'assets/image/delivery-truck.png',
                                                  width: 100,
                                                  height: 90),
                                              const SizedBox(height: 4),
                                              const Text('Tracking',
                                                  style: TextStyle(
                                                      fontFamily: 'font3',
                                                      fontSize: 20)),
                                              const Text('Information',
                                                  style: TextStyle(
                                                      fontFamily: 'font3',
                                                      fontSize: 20))
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) =>
                                            Information()));
                                  },
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15)),
                                      child: Container(
                                          padding: EdgeInsets.all(15),
                                          height: 150,
                                          width:
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.45,
                                          child: Column(children: <Widget>[
                                            Image.asset('assets/image/qa.png',
                                                width: 100, height: 90),
                                            const SizedBox(height: 5),
                                            const Text('Community',
                                                style: TextStyle(
                                                    fontFamily: 'font3',
                                                    fontSize: 20))
                                          ]))),
                                )
                              ],
                            ),
                          )
//
//                ),
                        ],
                      ),
                    ],
                  ),
                )
              ]));
        });
  }
}
