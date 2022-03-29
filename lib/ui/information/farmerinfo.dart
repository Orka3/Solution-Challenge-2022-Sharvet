import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdscsolution/ui/information/Hit.dart';
import 'package:gdscsolution/ui/information/giverinfo.dart';
import 'package:provider/provider.dart';

import '../../model/login_model.dart';


class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {

  final r = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final job = context
        .watch<FirebaseAuthService>()
        .job;
    return (job == "farmer") ?
    FarmerInfo() : GiverInfo();
  }
}


class FarmerInfo extends StatefulWidget {
  @override
  State<FarmerInfo> createState() => _FarmerInfoState();
}

class _FarmerInfoState extends State<FarmerInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 250,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/Farminfo.png'),
                      fit: BoxFit.fill)),
            ),
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Hit()));
                    },
                    child: Card(
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.9,
                        height: 100,
                        child: Center(child: Text(
                          "Livestock Hit index Forecast",
                          style: TextStyle(
                              fontSize: 20, fontFamily: "GmarketSans"
                              , fontWeight: FontWeight.w500),)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Hit()));
                    },
                    child: Card(
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.9,
                        height: 100,
                        child: Center(child: Text(
                          "Livestock price",
                          style: TextStyle(
                              fontSize: 20, fontFamily: "GmarketSans"
                              , fontWeight: FontWeight.w500),)),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
