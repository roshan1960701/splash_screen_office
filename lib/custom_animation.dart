import 'package:flutter/material.dart';
import 'package:splash_screen/second.dart';
import 'package:spring_button/spring_button.dart';
import 'dart:async';
import 'package:animations/animations.dart';

class custom_animation {
  Timer timer;
  int counter = 0;

  Widget customTransition(color, openBuilder, closeBuilder) {
    return OpenContainer(
        openColor: color,
        transitionType: ContainerTransitionType.fade,
        transitionDuration: Duration(milliseconds: 800),
        openBuilder: (context, _) => openBuilder,
        closedElevation: 1.0,
        openElevation: 50.0,
        /*openShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                      side: BorderSide(color: Colors.white, width: 1)),*/
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
          /*side: BorderSide(color: Colors.white, width: 1)*/
        ),
        closedColor: Colors.red,
        closedBuilder: (context, _) => closeBuilder);
  }

  Widget customButton(text, second, decrementCounter, incrementCounter) {
    return SpringButton(
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
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        second;
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => second));
      },
      onTapDown: (_) => decrementCounter,
      onLongPress: () => timer = Timer.periodic(
        const Duration(milliseconds: 100),
        (_) => incrementCounter,
      ),
      onLongPressEnd: (_) {
        timer?.cancel();
      },
    );
  }

  Widget customMaterialButton(onPressed(), text, color) {
    return MaterialButton(
      onPressed: () {
        onPressed();
      },
      child: Text(text),
      color: color,
      minWidth: 150,
      height: 40,
    );
  }
}
