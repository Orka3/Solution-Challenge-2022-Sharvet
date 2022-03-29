import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdscsolution/ui/vegetable/vegetdetail.dart';

Widget VegetCard(context, uid, name, sort, amount, date,address,contact,ps,possible, postid) {
  final r = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => VegetDetail(
        address:address,
        amount: amount,
        contact: contact,
        date:date,
        name: name,
        possible: possible,
        ps: ps,
        sort: sort,
        uid: uid,
        postid:postid
      )));
    },
    child: Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey,
              width: 80,
              height: 80,
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'welcome',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      cut('$amount $sort'),
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'welcome',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
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
              ],
            ),
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
                              firestore
                                  .collection('posting')
                                  .doc(name)
                                  .delete();
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
      ),
    ),
  );
}

String cut(string) {
  if (string.length >= 28) {
    return '${string.substring(0, 28)}..';
  }
  return string;
}
