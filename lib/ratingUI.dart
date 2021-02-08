import 'package:flutter/material.dart';
import 'package:splash_screen/appRate.dart';

class ratingUI extends StatefulWidget {
  @override
  _ratingUIState createState() => _ratingUIState();
}

class _ratingUIState extends State<ratingUI> {
  @override

  appRate _appRate = new appRate();


  @override
  void initState() {
    super.initState();

    _appRate.getRateInfo(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Hello"),
      ),
    );
  }
}
