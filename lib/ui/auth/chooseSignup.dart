import 'package:flutter/material.dart';
import 'package:gdscsolution/ui/auth/signup.dart';

class ChooseSign extends StatelessWidget {
  static Color mainColor = const Color(0xff00C776);
  late String choice;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text("Join As...",style: TextStyle(color: Colors.black,fontSize: 30),),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
                width: width,
                height: 300,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/image/nature.png"),
                        fit: BoxFit.fitHeight))),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignUpPage(choice: "farmer")));
              },
              child: Container(
                color: mainColor,
                height: 60,
                width: 250,
                child: const Center(
                  child: Text(
                    "Farmer",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'GmarketSans'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignUpPage(choice: "giver")));
              },
              child: Container(
                color: mainColor,
                height: 60,
                width: 250,
                child: const Center(
                    child: Text(
                  "Giver",
                  style:  TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'GmarketSans'),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
