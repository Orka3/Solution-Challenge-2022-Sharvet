import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdscsolution/component/InputForm.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../methods/upload.dart';
import '../../model/login_model.dart';

class Posting extends StatefulWidget {
  @override
  _PostingState createState() => _PostingState();
}

class _PostingState extends State<Posting> {
  static Color mainColor = const Color(0xff00C776);
  TextEditingController amountInputController = TextEditingController();
  TextEditingController sortInputController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  TextEditingController psInputController = TextEditingController();
  TextEditingController possibleInputController = TextEditingController();

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
        print(_selectedDate);
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        title: Text('Posting'),
        backgroundColor: mainColor,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 30),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: context.read<FirebaseAuthService>().getData(r?.uid),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (!snapshot.hasData) return Container();
                    return Container(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                upload(
                                  'gallery',snapshot.data!['bname']
                                );
                              },
                              child: Container(
                                color: Colors.grey[200],
                                height: MediaQuery.of(context).size.height / 5,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add),
                                      Text("Add the picture")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'giver name: ${snapshot.data!['bname']}',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'giver address: ${snapshot.data!['baddress']}',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'giver contact: ${snapshot.data!['contact']}',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  OutlinedButton(
                                      onPressed: () {
                                        _selectDate(context);
                                      },
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.all(5))),
                                      child: Text(
                                        'possible date',
                                        style: TextStyle(color: Colors.grey),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 180,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey))),
                                    child: _range == ''
                                        ? Text(
                                            'click the button!',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        : Text(
                                            _range,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                  ),
                                ],
                              ),
                              buildInput(
                                  "sort of vegetable (potato, cabbage...)",
                                  sortInputController),
                              buildInput("amount of vegetable (@@kg)",
                                  amountInputController),
                              buildInput("p.s.", psInputController),
                              buildInput(
                                  "possible address", possibleInputController),
                              GestureDetector(
                                onTap: () async {
                                  _posting(
                                      snapshot.data!['bname'],
                                      snapshot.data!['baddress'],
                                      snapshot.data!['contact'],
                                      _range,
                                      sortInputController.text,
                                      amountInputController.text,
                                      psInputController.text,
                                      possibleInputController.text);
                                },
                                child: Container(
                                    height: 40,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 60),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: mainColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Posting',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
  String _chars = 'AaBbCcDdEeFfGgHh';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final r = FirebaseAuth.instance.currentUser;

  Future _posting(
      name, address, contact, date, sort, amount, ps, possible) async {
    String postKey = getRandomString(8);
    fireStore.collection('posting').doc(postKey).set({
      'name': name,
      'address': address,
      'contact': contact,
      'date': date,
      'sort': sort,
      'amount': amount,
      'ps': ps,
      'possible': possible,
      'uid': r?.uid,
      'reservation': 'none'
    });
    Navigator.pop(context);
  }

  _selectDate(BuildContext context) {
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("달력"),
      actions: [
        okButton,
      ],
      content: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.8,
        child: SfDateRangePicker(
          onSelectionChanged: _onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.range,
          initialSelectedRange: PickerDateRange(
              DateTime.now().subtract(const Duration(days: 4)),
              DateTime.now().add(const Duration(days: 3))),
        ),
      ),
    );

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
