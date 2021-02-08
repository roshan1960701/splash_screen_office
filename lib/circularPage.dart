import 'package:flutter/material.dart';
import 'package:circular_splash_transition/circular_splash_transition.dart';
import 'package:splash_screen/Screen.dart';
import 'package:splash_screen/fourth.dart';

class circularPage extends StatefulWidget {
  @override
  _circularPageState createState() => _circularPageState();
}

class _circularPageState extends State<circularPage> {

  CircularSplashController _controller = CircularSplashController(
    color: Colors.white, //optional, default is White.
    duration: Duration(milliseconds: 300), //optional.
  );

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return CircularSplash(
      // onWillPop: _onWillPop(),
      controller: _controller,
      child: GestureDetector(child: Container(),
        onTap: () async {
           Navigator.push(context, MaterialPageRoute(builder: (context) => Screen(title: "Circle",color: Colors.greenAccent,)));

        },
      ),
    );
  }
}
