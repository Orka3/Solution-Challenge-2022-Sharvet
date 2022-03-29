import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gdscsolution/ui/vegetable/postingveget.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../component/VegetCard.dart';

class Sellveget extends StatefulWidget {
  var job;

  Sellveget({this.job});

  @override
  _SellvegetState createState() => _SellvegetState(job);
}

class _SellvegetState extends State<Sellveget> {
  static Color mainColor = const Color(0xff00C776);
  TextEditingController searchTextEditingController = TextEditingController();
  late Future<QuerySnapshot> futureSearchResults;
  var _currentIndex = 0;

  var job;

  _SellvegetState(this.job);

  emptyTheTextFormField() {
    searchTextEditingController.clear();
  }

  controlSearching(str) {
    print(str);
    Future<QuerySnapshot> allUsers = FirebaseFirestore.instance
        .collection('posting')
        .where('profileName', isGreaterThanOrEqualTo: str)
        .get();
    setState(() {
      futureSearchResults = allUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        titleSpacing: 0,
        title: Container(
          padding: EdgeInsets.only(top: 10, right: 10),
          width: MediaQuery.of(context).size.width - 20,
          child: TextFormField(
            controller: searchTextEditingController, // 검색창 controller
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none),
                fillColor: Color(0xffe6e6ec),
                filled: true,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey,
                    ),
                    onPressed: emptyTheTextFormField)),
            style: TextStyle(
              fontSize: 15,
            ),
            onFieldSubmitted: controlSearching,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: false,
      ),
      floatingActionButton:
      job =='giver'?
      FloatingActionButton.extended(
        backgroundColor: mainColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Posting()));
        },
        tooltip: 'Increment',
        icon: const Icon(Icons.add),
        label: const Text("Add the post"),
      ):Container(),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('posting').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, index) => Container(
                    padding: const EdgeInsets.all(8),
                    child: (snapshot.data!.docs[index]['reservation'] == 'none')
                        ? Column(
                            children: [
                              VegetCard(
                                context,
                                snapshot.data!.docs[index]['uid'],
                                snapshot.data!.docs[index]['name'],
                                snapshot.data!.docs[index]['sort'],
                                snapshot.data!.docs[index]['amount'],
                                snapshot.data!.docs[index]['date'],
                                snapshot.data!.docs[index]['address'],
                                snapshot.data!.docs[index]['contact'],
                                snapshot.data!.docs[index]['ps'],
                                snapshot.data!.docs[index]['possible'],
                                snapshot.data!.docs[index].id
                              )
                            ],
                          )
                        : Container()));
          },
        ),
      ),
    );
  }
}
