import 'package:flutter/material.dart';
import 'package:gdscsolution/ui/homepage.dart';
import 'package:gdscsolution/ui/profile/profilepage.dart';
import 'package:gdscsolution/ui/reservation/reservationpage.dart';
import 'package:gdscsolution/ui/vegetable/vegetable.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'information/farmerinfo.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _currentIndex = 0;
  List _pages = [HomePage(), Reservation(), Veget(), Information(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_currentIndex], // 페이지와 연결
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.blue,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text("Likes"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
            selectedColor: Colors.orange,
          ),
          SalomonBottomBarItem(
            icon: Image( image:AssetImage("assets/image/info.png"),
            width: 23,height: 23,),
            title: Text("Information"),
            selectedColor: Colors.green,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
