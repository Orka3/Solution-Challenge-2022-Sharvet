
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/login_model.dart';

class GiverInfo extends StatefulWidget {
  @override
  State<GiverInfo> createState() => _GiverInfoState();
}

class _GiverInfoState extends State<GiverInfo> {
  final r = FirebaseAuth.instance.currentUser;
  Map benefit ={"Bronze": "1. You can use bronze eco-friendly mark.\n\n2. You can get bronze-level promotions.\n",
    "Silver": "1. You can use silver eco-friendly mark.\n2. You can get silver-level promotions..",
  "Gold": "1. You can use gold eco-friendly mark.\n2. You can get gold-level promotions." };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Rank",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
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
                  return Column(
                    children: [
                      Container(
                        color: Colors.grey[200],
                        height: 330,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your Ranking",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    Container(
                                        child: (rank == "Bronze")
                                            ? Column(children: [
                                                Image.asset(
                                                  "assets/image/bronze-medal.png",
                                                  width: 100,
                                                  height: 100,
                                                ),
                                                Text(
                                                  "Bronze",
                                                  style: TextStyle(
                                                      fontFamily: "hambak",
                                                      fontSize: 30),
                                                ),
                                                SizedBox(height: 20),
                                                (mile! % 500 == 0)
                                                    ? Image.asset(
                                                        "assets/image/0.png",
                                                        width: 300,
                                                      )
                                                    : mile! % 500 == 100
                                                        ? Image.asset(
                                                            "assets/image/1.png",
                                                            width: 300,
                                                          )
                                                        : mile! % 500 == 200
                                                            ? Image.asset(
                                                                "assets/image/2.png",
                                                                width: 300,
                                                              )
                                                            : mile! % 500 == 300
                                                                ? Image.asset(
                                                                    "assets/image/3.png",
                                                                    width: 300,
                                                                  )
                                                                : mile! % 500 ==
                                                                        400
                                                                    ? Image
                                                                        .asset(
                                                                        "assets/image/4.png",
                                                                        width:
                                                                            300,
                                                                      )
                                                                    : Container(),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Text(
                                                  '$mile /500',
                                                  style: TextStyle(
                                                      fontFamily: "hambak"),
                                                )
                                              ])
                                            : rank == "Silver"
                                                ? Column(
                                                    children: [
                                                      Image.asset(
                                                        "assets/image/gold-medal.png",
                                                        width: 100,
                                                        height: 100,
                                                      ),
                                                      Text(
                                                        "Silver",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "hambak",
                                                            fontSize: 30),
                                                      ),
                                                      SizedBox(height: 20),
                                                      (mile! % 500 == 0)
                                                          ? Image.asset(
                                                              "assets/image/0.png",
                                                              width: 300,
                                                              height: 100,
                                                            )
                                                          : mile! % 500 == 100
                                                              ? Image.asset(
                                                                  "assets/image/1.png",
                                                                  width: 300,
                                                                  height: 100,
                                                                )
                                                              : mile! % 500 ==
                                                                      200
                                                                  ? Image.asset(
                                                                      "assets/image/2.png",
                                                                      width:
                                                                          300,
                                                                      height:
                                                                          100,
                                                                    )
                                                                  : mile! % 500 ==
                                                                          300
                                                                      ? Image
                                                                          .asset(
                                                                          "assets/image/3.png",
                                                                          width:
                                                                              300,
                                                                          height:
                                                                              100,
                                                                        )
                                                                      : mile! % 500 ==
                                                                              400
                                                                          ? Image
                                                                              .asset(
                                                                              "assets/image/4.png",
                                                                              width: 300,
                                                                              height: 100,
                                                                            )
                                                                          : Container(),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      Text(
                                                        '$mile /2000',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "hambak"),
                                                      )
                                                    ],
                                                  )
                                                : rank == "Gold"
                                                    ? Column(
                                                        children: [
                                                          Image.asset(
                                                            "assets/image/gold-medal.png",
                                                            width: 100,
                                                            height: 100,
                                                          ),
                                                          Text(
                                                            "Gold",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "hambak",
                                                                fontSize: 30),
                                                          ),
                                                          SizedBox(height: 20),
                                                          (mile! % 500 == 0)
                                                              ? Image.asset(
                                                                  "assets/image/0.png",
                                                                  width: 300,
                                                                  height: 100,
                                                                )
                                                              : mile! % 500 ==
                                                                      100
                                                                  ? Image.asset(
                                                                      "assets/image/1.png",
                                                                      width:
                                                                          300,
                                                                      height:
                                                                          100,
                                                                    )
                                                                  : mile! % 500 ==
                                                                          200
                                                                      ? Image
                                                                          .asset(
                                                                          "assets/image/2.png",
                                                                          width:
                                                                              300,
                                                                          height:
                                                                              100,
                                                                        )
                                                                      : mile! % 500 ==
                                                                              300
                                                                          ? Image
                                                                              .asset(
                                                                              "assets/image/3.png",
                                                                              width: 300,
                                                                              height: 100,
                                                                            )
                                                                          : mile! % 500 == 400
                                                                              ? Image.asset(
                                                                                  "assets/image/4.png",
                                                                                  width: 300,
                                                                                  height: 100,
                                                                                )
                                                                              : Container(),
                                                          SizedBox(
                                                            height: 30,
                                                          ),
                                                          Text(
                                                            '$mile /5000',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "hambak"),
                                                          )
                                                        ],
                                                      )
                                                    : Container()),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Benefit",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 15,),
                            Container(
                              child:
                                Text(benefit[rank],
                                style: TextStyle(fontSize: 18),)

                            )
                          ],
                        ),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  );
                });
          }),
    );
  }
}
