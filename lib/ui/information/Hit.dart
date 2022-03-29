import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Hit extends StatefulWidget {
  @override
  _HitState createState() => _HitState();
}

class _HitState extends State<Hit> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('nong'),),
      backgroundColor: Colors.white,
      body:WebView(
        initialUrl: "https://www.naver.com/",
      )
    );
  }
}
