import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:spring_button/spring_button.dart';

class customButton extends StatefulWidget {
  customButton({@required this.onPressed, @required this.container});
  final GestureTapCallback onPressed;
  final Container container;
  @override
  _customButtonState createState() =>
      _customButtonState(onPressed: onPressed, container: container);
}

class _customButtonState extends State<customButton> {
  _customButtonState({@required this.onPressed, @required this.container});
  final GestureTapCallback onPressed;
  final Container container;

  Timer timer;
  int counter = 0;

  incrementCounter() {
    setState(() {
      counter++;
    });
  }

  decrementCounter() {
    setState(() {
      counter--;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return SpringButton(
      SpringButtonType.OnlyScale,
      container,
      scaleCoefficient: 0.9,
      onTap: onPressed,
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
}
