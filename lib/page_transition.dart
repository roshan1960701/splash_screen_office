import 'dart:async';

import 'package:flutter/material.dart';
import 'package:splash_screen/customButton.dart';
import 'package:splash_screen/custom_animation.dart';
import 'package:splash_screen/second.dart';
import 'package:spring_button/spring_button.dart';

class page_transition extends StatefulWidget {
  @override
  _page_transitionState createState() => _page_transitionState();
}

class _page_transitionState extends State<page_transition>
    with TickerProviderStateMixin {
  custom_animation _custom_animation = new custom_animation();

  AnimationController _animationController;
  AnimationController _animationController2;
  Timer timer;
  int counter = 0;
  bool check = false;
  bool valid = false;

  incrementCounter() {
    setState(() {
      counter++;
      valid = true;
    });
  }

  decrementCounter() {
    setState(() {
      counter--;
    });
  }

  gotoSecondPage() {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => second()));
    setState(() {
      check = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 50),
      vsync: this,
      lowerBound: -1.0,
      upperBound: 0.4,
    )..addListener(() {
        setState(() {});
      });
    ;

    _animationController2 = AnimationController(
      duration: Duration(milliseconds: 50),
      vsync: this,
      lowerBound: 0,
      upperBound: 0.5,
    )..addListener(() {
        setState(() {});
      });
  }

  onTap() {
    _animationController.reverse();
  }

  onTapDownInkwell(TapDownDetails details) {
    _animationController.forward();
  }

  onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  onTapCancel() {
    _animationController.reverse();
  }

  onTapUp2(TapUpDetails details) {
    _animationController2.reverse();
  }

  onTapDown2(TapDownDetails details) {
    _animationController2.forward();
  }

  onTapCancel2() {
    _animationController2.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scale1 = 1 + _animationController.value;
    double scale2 = 1 + _animationController2.value;
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.orange,
                Colors.red,
              ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100),
            GestureDetector(
              // onTap: onTap,
              // onTapDown: onTapDownInkwell,
              onTapUp: onTapUp,
              onTapDown: onTapDown,
              onTapCancel: onTapCancel,
              child: Transform.scale(
                scale: scale1,
                child: Container(
                  alignment: Alignment.center,
                  height: h / 15,
                  width: w / 2,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: Container(
                      alignment: Alignment.center,
                      height: h / 20,
                      child: FlutterLogo(
                        size: 30,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: h * 0.03,
            ),
            SizedBox(
              height: h * 0.03,
            ),
            GestureDetector(
              onTapUp: onTapUp2,
              onTapDown: onTapDown2,
              onTapCancel: onTapCancel2,
              child: Transform.scale(
                scale: scale2,
                child: Container(
                  alignment: Alignment.center,
                  height: h / 15,
                  width: w / 2,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: Container(
                      alignment: Alignment.center,
                      height: h / 10,
                      child: FlutterLogo()),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SpringButton(
              SpringButtonType.OnlyScale,
              Container(
                width: 200,
                height: 45,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Center(
                  child: Text(
                    valid ? "Click Me":" hello",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

              ),
              useCache: false,

              onTap: (){
                valid == true ? valid = false : valid = true;
                print("Tapped!!!");
                setState(() {

                });
              },
             // onTapDown: (_) => incrementCounter(),
              onLongPress: () => timer = Timer.periodic(
                const Duration(milliseconds: 100),
                (_) => incrementCounter(),
              ),
              onLongPressEnd: (_) {
                timer?.cancel();
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            SpringButton(
              SpringButtonType.OnlyScale,
              Container(
                width: 200,
                height: 45,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Center(
                  child: Text(
                    "Click Me",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onTap: () {
                Future.delayed(Duration(milliseconds: 600), () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => second()));
                });
              },
              onTapDown: (_) => decrementCounter(),
              onLongPress: () => timer = Timer.periodic(
                const Duration(milliseconds: 100),
                (_) => incrementCounter(),
              ),
              onLongPressEnd: (_) {
                timer?.cancel();
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            /*_custom_animation.customButton("Hello world", gotoSecondPage,
                incrementCounter(), decrementCounter()),*/
            SizedBox(
              height: 10.0,
            ),
            _custom_animation.customTransition(
                Colors.amber,
                second(),
                Container(
                  width: 200,
                  height: 45,
                  child: Center(
                      child: Text(
                    "Hello",
                    style: TextStyle(color: Colors.white),
                  )),
                  color: Colors.red,
                )),
            _custom_animation.customMaterialButton(
                helloText(), "CLick here", Colors.greenAccent),

            customButton(
                onPressed: () {
                  Future.delayed(Duration(milliseconds: 800), () {
                    setState(() {
                      check = true;
                    });
                  });
                },
                container: Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(100)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [Icon(check ? Icons.face : Icons.accessibility), Text("Roshan")],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  helloText() {
    print("Cliked!!!!");
    setState(() {
      check = true;
    });
  }
}
