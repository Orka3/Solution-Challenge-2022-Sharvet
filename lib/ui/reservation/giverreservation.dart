import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdscsolution/ui/reservation/newReservation.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart' show StreamGroup;
import '../../model/login_model.dart';

class giverReservation extends StatefulWidget {
  @override
  State<giverReservation> createState() => _giverReservationState();
}

class _giverReservationState extends State<giverReservation> {
  final r = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var first =FirebaseFirestore.instance
        .collection('reservation')
        .where('reservation.' + 'giveruid', isEqualTo: r?.uid)
        .where('state', isEqualTo: 'checked')
        .snapshots();
    var second = FirebaseFirestore.instance
        .collection('reservation')
        .where('reservation.' + 'giveruid', isEqualTo: r?.uid)
        .where('state', isEqualTo: 'transit')
        .snapshots();
    List<Stream<QuerySnapshot>> streams = [first,second];
    Stream<QuerySnapshot> results = StreamGroup.merge(streams);
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: (Text(
            'Reservation lists',
            style: TextStyle(color: Colors.black),
          )),
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('reservation')
                      .where('reservation.' + 'giveruid', isEqualTo: r?.uid)
                      .where('state', isEqualTo: 'reserved')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.data != null) {
                      return Column(children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          alignment: Alignment.center,
                          color: Color(0xff1D3A1A),
                          child: const Text(
                            'New Reservation',
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'GmarketSans',
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (ctx, index) {
                              var reservation = snapshot.data?.docs[index];
                              return FutureBuilder(
                                  future: context
                                      .read<FirebaseAuthService>()
                                      .getData(reservation?['farmeruid']),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot1) {
                                    if (snapshot1.data != null) {
                                      var farmer = snapshot1.data;
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(children: [
                                              Card(
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 130,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: GestureDetector(
                                                            onTap: () {
                                                              if (farmer
                                                                      ?.data !=
                                                                  null) {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            NewReservation(
                                                                              postid: reservation!['postid'],
                                                                              fname: farmer!['name'],
                                                                              fbname: farmer!['bname'],
                                                                              faddress: farmer!['baddress'],
                                                                              fcontact: farmer!['contact'],
                                                                              gname: reservation['reservation']['name'],
                                                                              gaddress: reservation['reservation']['address'],
                                                                              gcontact: reservation['reservation']['contact'],
                                                                              amount: reservation['reservation']['amount'],
                                                                              sort: reservation['reservation']['sort'],
                                                                              date: reservation['reservation']['date'],
                                                                              ps: reservation['reservation']['ps'],
                                                                              state: reservation['state'],
                                                                              postKey: reservation['postKey'],
                                                                              job: 'giver',
                                                                            )));
                                                              }
                                                              ;
                                                            },
                                                            child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            15,
                                                                        top:
                                                                            10),
                                                                child:
                                                                    const Text(
                                                                  '> See detail',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blue,
                                                                      fontSize:
                                                                          15),
                                                                ))),
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20),
                                                            child: Container(
                                                              width: 80,
                                                              height: 80,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'PostID: ${reservation!['postid']}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                Text(
                                                                    'Client name : ${farmer?['name']}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.w500)),
                                                                Text(
                                                                    'Client farm : ${farmer?['bname']}',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.w500)),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ]),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  });
                            }),
                      ]);
                    } else {
                      return Container();
                    }
                  }),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('reservation')
                      .where('reservation.' + 'giveruid', isEqualTo: r?.uid)
                      .where('state', isEqualTo: 'checked')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.data != null) {
                      return Column(children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          alignment: Alignment.center,
                          color: const Color(0xff1D3A1A),
                          child: const Text(
                            'Checked Reservation',
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'GmarketSans',
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (ctx, index) {
                              var reservation = snapshot.data?.docs[index];

                              if (reservation?['reservation']['giveruid'] ==
                                  r?.uid) {
                                return FutureBuilder(
                                    future: context
                                        .read<FirebaseAuthService>()
                                        .getData(reservation?['farmeruid']),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            snapshot1) {
                                      if (snapshot1.data != null) {
                                        var farmer = snapshot1.data;
                                        return Column(children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  Card(
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 130,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: GestureDetector(
                                                                onTap: () {
                                                                  if (farmer
                                                                          ?.data !=
                                                                      null) {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                NewReservation(
                                                                          postid:
                                                                              reservation!['postid'],
                                                                          fname:
                                                                              farmer!['name'],
                                                                          fbname:
                                                                              farmer!['bname'],
                                                                          faddress:
                                                                              farmer!['baddress'],
                                                                          fcontact:
                                                                              farmer!['contact'],
                                                                          gname:
                                                                              reservation!['reservation']['name'],
                                                                          gaddress:
                                                                              reservation!['reservation']['address'],
                                                                          gcontact:
                                                                              reservation!['reservation']['contact'],
                                                                          amount:
                                                                              reservation!['reservation']['amount'],
                                                                          sort: reservation!['reservation']
                                                                              [
                                                                              'sort'],
                                                                          date: reservation!['reservation']
                                                                              [
                                                                              'date'],
                                                                          ps: reservation!['reservation']
                                                                              [
                                                                              'ps'],
                                                                          state:
                                                                              reservation!['state'],
                                                                          postKey:
                                                                              reservation!['postKey'],
                                                                          job:
                                                                              'giver',
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  ;
                                                                },
                                                                child: Container(
                                                                    padding: EdgeInsets.only(right: 15, top: 10),
                                                                    child: const Text(
                                                                      '> See detail',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .blue,
                                                                          fontSize:
                                                                              15),
                                                                    ))),
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            20),
                                                                child:
                                                                    Container(
                                                                  width: 80,
                                                                  height: 80,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            20),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'PostID: ${reservation!['postid']}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    Text(
                                                                        'Client name : ${farmer?['name']}',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                17,
                                                                            fontWeight:
                                                                                FontWeight.w500)),
                                                                    Text(
                                                                        'Client farm : ${farmer?['bname']}',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                17,
                                                                            fontWeight:
                                                                                FontWeight.w500)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ))
                                        ]);
                                      } else {
                                        return Container(
                                          child: Text(
                                            'There is no reservation',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                        );
                                      }
                                    });
                              } else {
                                return Container(
                                  child: Text(
                                    'There is no reservation',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                );
                              }
                            }),
                      ]);
                    } else {
                      return Container(
                        child: Text(
                          'There is no reservation',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      );
                    }
                  }),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('reservation')
                    .where('reservation.' + 'giveruid', isEqualTo: r?.uid)
                    .where('state', isEqualTo: 'delivered')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.data != null) {
                    return Column(children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        alignment: Alignment.center,
                        color: Color(0xff1D3A1A),
                        child: const Text(
                          'Finished Reservation',
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'GmarketSans',
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (ctx, index) {
                            var reservation = snapshot.data?.docs[index];

                            if (reservation?['reservation']['giveruid'] ==
                                r?.uid) {
                              return FutureBuilder(
                                  future: context
                                      .read<FirebaseAuthService>()
                                      .getData(reservation?['farmeruid']),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot1) {
                                    if (snapshot1.data != null) {
                                      var farmer = snapshot1.data;
                                      return Column(children: [
                                        Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              children: [
                                                reservation!['state'] ==
                                                        'delivered'
                                                    ? Card(
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: 130,
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: GestureDetector(
                                                                    onTap: () {
                                                                      if (farmer
                                                                              ?.data !=
                                                                          null) {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                NewReservation(
                                                                              postid: reservation['postid'],
                                                                              fname: farmer!['name'],
                                                                              fbname: farmer!['bname'],
                                                                              faddress: farmer!['baddress'],
                                                                              fcontact: farmer!['contact'],
                                                                              gname: reservation['reservation']['name'],
                                                                              gaddress: reservation['reservation']['address'],
                                                                              gcontact: reservation['reservation']['contact'],
                                                                              amount: reservation['reservation']['amount'],
                                                                              sort: reservation['reservation']['sort'],
                                                                              date: reservation['reservation']['date'],
                                                                              ps: reservation['reservation']['ps'],
                                                                              state: reservation['state'],
                                                                              postKey: reservation['postKey'],
                                                                              job: 'giver',
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      ;
                                                                    },
                                                                    child: Container(
                                                                        padding: EdgeInsets.only(right: 15, top: 10),
                                                                        child: Text(
                                                                          '> See detail',
                                                                          style: TextStyle(
                                                                              color: Colors.blue,
                                                                              fontSize: 15),
                                                                        ))),
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                20),
                                                                    child:
                                                                        Container(
                                                                      width: 80,
                                                                      height:
                                                                          80,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                20),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          'PostID: ${reservation['postid']}',
                                                                          style: TextStyle(
                                                                              fontSize: 17,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                        Text(
                                                                            'Client name : ${farmer?['name']}',
                                                                            style:
                                                                                TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                                                                        Text(
                                                                            'Client farm : ${farmer?['bname']}',
                                                                            style:
                                                                                TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ))
                                      ]);
                                    } else {
                                      return Container();
                                    }
                                  });
                            } else {
                              return Container(child: Text('eee'));
                            }
                          })
                    ]);
                  } else {
                    return Container(
                      child: Text(
                        'There is no reservation',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }
}
