import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/login_model.dart';

class NewReservation extends StatefulWidget {
  NewReservation({this.postid,
    this.fname,
    this.fbname,
    this.faddress,
    this.fcontact,
    this.gname,
    this.gaddress,
    this.gcontact,
    this.amount,
    this.sort,
    this.date,
    this.ps,
    this.state,
    this.postKey,
    this.job});

  var postid,
      fname,
      fbname,
      faddress,
      fcontact,
      gname,
      gaddress,
      gcontact,
      amount,
      sort,
      date,
      ps,
      state,
      postKey,
      job;

  @override
  State<NewReservation> createState() =>
      _NewReservationState(
        postid: postid,
        fname: fname,
        fbname: fbname,
        faddress: faddress,
        fcontact: fcontact,
        gname: gname,
        gaddress: gaddress,
        gcontact: gcontact,
        amount: amount,
        sort: sort,
        date: date,
        ps: ps,
        state1: state,
        postKey: postKey,
        job: job,
      );
}

class _NewReservationState extends State<NewReservation> {
  _NewReservationState({this.postid,
    this.fname,
    this.fbname,
    this.faddress,
    this.fcontact,
    this.gname,
    this.gaddress,
    this.gcontact,
    this.amount,
    this.sort,
    this.date,
    this.ps,
    this.state1,
    this.postKey,
    this.job});

  var postid,
      fname,
      fbname,
      faddress,
      fcontact,
      gname,
      gaddress,
      gcontact,
      amount,
      sort,
      date,
      ps,
      state1,
      postKey,
      job;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final r = FirebaseAuth.instance.currentUser;


  Map imgstate = {
    'reserved': 'assets/image/delivery.png',
    'checked': 'assets/image/delivery1.png',
    'transit': 'assets/image/delivery2.png',
    'delivered': 'assets/image/delivery3.png'
  };
  Map buttonstate = {
    'reserved': 'Check the reservation',
    'checked': 'The product is in transit',
    'transit': 'The product is delivered',
    'delivered': 'The process is finished'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color(0xff1D3A1A),
        title: Text('Being Reserved'),
        elevation: 0,
      ),
      body: FutureBuilder<String>(
          future: context.watch<FirebaseAuthService>().getrank(r?.uid),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            var rank = snapshot.data;
            return FutureBuilder<int>(
                future: context.watch<FirebaseAuthService>().getmile(r?.uid),
                builder: (BuildContext context, snapshot1) {
                  if (snapshot1.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  var mile = snapshot1.data;

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: Image.asset(
                            imgstate[state1],
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Client Information',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'welcome',
                                    fontWeight: FontWeight.w500),
                              ),
                              Card(
                                child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  padding: const EdgeInsets.only(
                                      top: 20,
                                      right: 40,
                                      left: 20,
                                      bottom: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          const Text(
                                            'Client name',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'GmarketSans'),
                                          ),
                                          Text(
                                            fname,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'GmarketSans'),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          const Text(
                                            'Client farm',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'GmarketSans'),
                                          ),
                                          Text(
                                            fbname,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'GmarketSans'),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          const Text(
                                            'Client address',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'GmarketSans'),
                                          ),
                                          Text(
                                            faddress,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'GmarketSans'),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          const Text(
                                            'Client contact',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'GmarketSans'),
                                          ),
                                          Text(
                                            fcontact,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'GmarketSans'),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Post Information',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'welcome',
                                    fontWeight: FontWeight.w500),
                              ),
                              Card(
                                child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  padding: const EdgeInsets.only(
                                      top: 20,
                                      right: 40,
                                      left: 20,
                                      bottom: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          const Text(
                                            'PostID',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'GmarketSans'),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            postid,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'GmarketSans'),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          const Text(
                                            'Sort of Vegetables',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'GmarketSans'),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              sort,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'GmarketSans'),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          const Text(
                                            'Amount of Vegetables',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'GmarketSans'),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              amount,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'GmarketSans'),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          const Text(
                                            'Possible date',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'GmarketSans'),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              date,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'GmarketSans'),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        (job == 'giver')
                            ? Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                _check(state1,rank,mile);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: state1 == 'delivered'
                                        ? Colors.grey
                                        : Color(0xff1D3A1A),
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  buttonstate[state1],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'welcome',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ))
                            : Container(),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  );
                }
            );
          }
      ),
    );
  }
  void _check(state1, rank, mileage) {
    if (state1 == 'reserved') {
      firestore
          .collection('reservation')
          .doc(postKey)
          .update({'state': 'checked'});
      Navigator.pop(context);
    } else if (state1 == 'checked') {
      firestore
          .collection('reservation')
          .doc(postKey)
          .update({'state': 'transit'});
      Navigator.pop(context);
    } else if (state1 == 'transit') {
      firestore
          .collection('reservation')
          .doc(postKey)
          .update({'state': 'delivered'});

      if (rank == "Bronze") {
        if (mileage + 100 == 500) {
          firestore
              .collection('users').doc(r?.uid).update({
            "mileage": mileage + 100,
            "rank": "Silver"});
        } else {
          firestore
              .collection('users').doc(r?.uid).update(
              {"mileage": mileage + 100});
        }
      }else if(rank =="Silver") {
        if (mileage + 100 == 2000) {
          firestore
              .collection('users').doc(r?.uid).update({
            "mileage": mileage + 100,
            "rank": "Gold"});
        } else {
          firestore
              .collection('users').doc(r?.uid).update(
              {"mileage": mileage + 100});
        }
      }else{
        if (mileage + 100 == 5000) {
          firestore
              .collection('users').doc(r?.uid).update({
            "rank": "VIP"});
        } else {
          firestore
              .collection('users').doc(r?.uid).update(
              {"mileage": mileage + 100});
        }
      }
    }
    setState(() {});
  }
}

