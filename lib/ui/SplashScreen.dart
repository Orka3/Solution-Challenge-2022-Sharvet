import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gdscsolution/ui/auth/login_page.dart';
import 'package:gdscsolution/ui/homepage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static Color mainColor = const Color(0xff00C776);

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: mainColor,
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.384375),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image(
                        image: AssetImage("assets/image/logo.png"),
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.15,
                      ),
                    ),
                    Container(
                      child: Image(
                        image: AssetImage("assets/image/header2.png"),
                        width: screenWidth * 0.5,
                        height: screenHeight * 0.0859375,
                      ),
                    ),

                  ],
                ),
                const Expanded(child: SizedBox()),
                Align(
                  child: Text("© Copyright 2022, MEG",
                      style: TextStyle(
                        fontSize: screenWidth * (14 / 360),
                        color: const Color.fromRGBO(255, 255, 255, 0.6),
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0625,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
