import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/login_model.dart';
import '../reservation/newReservation.dart';

class Profilef extends StatefulWidget {
  @override
  State<Profilef> createState() => _ProfilefState();
}

class _ProfilefState extends State<Profilef> {
  final r = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'MyProfile',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: context.watch<FirebaseAuthService>().getData(r?.uid),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: 70,
                            height: 70,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data!['rank'],
                            style: TextStyle(color: Colors.blue, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                snapshot.data!['name'],
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.grey,
                              )
                            ],
                          ),
                          Text(snapshot.data!['bname']),
                        ],
                      ),
                    ),
                    Divider(
                      height: 5,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height - 300,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Past delivery history',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('reservation')
                                      .where('farmeruid',
                                      isEqualTo: r?.uid)
                                      .where('state', isEqualTo: 'delivered')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {
                                      return SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height -
                                            400,
                                        child: ListView.builder(
                                          itemCount: snapshot.data?.docs.length,
                                          itemBuilder: (context, index) {
                                            var data =
                                            snapshot.data!.docs![index];
                                            return FutureBuilder(
                                                future: context
                                                    .read<FirebaseAuthService>()
                                                    .getData(
                                                    data?['farmeruid']),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<
                                                        DocumentSnapshot>
                                                    snapshot1) {
                                                  if (snapshot1.data != null) {
                                                    var farmer = snapshot1.data;
                                                    return Card(
                                                      child: Container(
                                                        height: 100,
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
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
                                                                            builder: (context) =>
                                                                                NewReservation(
                                                                                  postid:
                                                                                  data['postid'],
                                                                                  fname:
                                                                                  farmer!['name'],
                                                                                  fbname:
                                                                                  farmer!['bname'],
                                                                                  faddress:
                                                                                  farmer!['baddress'],
                                                                                  fcontact:
                                                                                  farmer!['contact'],
                                                                                  gname:
                                                                                  data['reservation']['name'],
                                                                                  gaddress:
                                                                                  data['reservation']['address'],
                                                                                  gcontact:
                                                                                  data['reservation']['contact'],
                                                                                  amount:
                                                                                  data['reservation']['amount'],
                                                                                  sort:
                                                                                  data['reservation']['sort'],
                                                                                  date:
                                                                                  data['reservation']['date'],
                                                                                  ps: data['reservation']['ps'],
                                                                                  state:
                                                                                  data['state'],
                                                                                  postKey:
                                                                                  data['postKey'],
                                                                                  job:
                                                                                  'giver',
                                                                                ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      ;
                                                                    },
                                                                    child:
                                                                    Container(
                                                                        padding: EdgeInsets.only(
                                                                            right:
                                                                            15,
                                                                            top:
                                                                            10),
                                                                        child:
                                                                        const Text(
                                                                          '> See detail',
                                                                          style:
                                                                          TextStyle(color: Colors.blue, fontSize: 15),
                                                                        ))),
                                                              ),
                                                              Text(
                                                                  "PostID: ${data['postid']}"),
                                                              Text(
                                                                  "Date: ${data['reservation']['date']}"),
                                                              Row(
                                                                children: [
                                                                  Card(
                                                                    child:
                                                                    Container(
                                                                      child: Text(
                                                                          ''),
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                });
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
