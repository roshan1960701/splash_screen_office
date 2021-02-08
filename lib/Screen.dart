import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  Screen({Key key, this.title,this.color}): super(key: key);
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Center(
        child: Text(title),
      ),

    );
  }
}
