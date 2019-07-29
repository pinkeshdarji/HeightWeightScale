import 'package:flutter/material.dart';
import 'package:height_weight_scale/ui/vertical_scale.dart';

class Example1 extends StatefulWidget {
  @override
  _Example1State createState() => _Example1State();
}

class _Example1State extends State<Example1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        VerticalScale(
          maxValue: 13,
          scaleController: ScrollController(),
        ),
        VerticalScale(
          maxValue: 25,
          scaleController: ScrollController(initialScrollOffset: 100),
          scaleColor: Colors.amberAccent,
          lineColor: Colors.deepPurple,
          linesBetweenTwoPoints: 7,
          middleLineAt: 4,
          textStyle: TextStyle(
              fontSize: 25,
              color: Colors.purple,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        VerticalScale(
          maxValue: 7,
          scaleController: ScrollController(initialScrollOffset: 200),
          scaleColor: Colors.redAccent,
          lineColor: Colors.amber,
          linesBetweenTwoPoints: 5,
          middleLineAt: 3,
          pointer: RotatedBox(
              quarterTurns: 1, child: Image.asset('assets/images/tooltip.png')),
          textStyle: TextStyle(
            fontSize: 35,
            color: Colors.amber,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ));
  }
}
