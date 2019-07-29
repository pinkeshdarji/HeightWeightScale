import 'package:flutter/material.dart';

import 'horizontalScale.dart';

class Example2 extends StatefulWidget {
  @override
  _Example2State createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        HorizontalScale(
          maxValue: 13,
          scaleController: ScrollController(),
        ),
        HorizontalScale(
          maxValue: 25,
          scaleController: ScrollController(initialScrollOffset: 300),
          scaleColor: Colors.amberAccent,
          lineColor: Colors.deepPurple,
          linesBetweenTwoPoints: 7,
          middleLineAt: 4,
          pointer: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(Icons.arrow_downward, color: Colors.purple),
          ),
          textStyle: TextStyle(
              fontSize: 18,
              color: Colors.purple,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        HorizontalScale(
          maxValue: 7,
          scaleController: ScrollController(initialScrollOffset: 500),
          scaleColor: Colors.redAccent,
          lineColor: Colors.amber,
          linesBetweenTwoPoints: 5,
          middleLineAt: 3,
          pointer: RotatedBox(
              quarterTurns: 2, child: Image.asset('assets/images/tooltip.png')),
          textStyle: TextStyle(
            fontSize: 20,
            color: Colors.amber,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        HorizontalScale(
          maxValue: 125,
          scaleController: ScrollController(initialScrollOffset: 400),
          scaleColor: Colors.black,
          lineColor: Colors.white,
          linesBetweenTwoPoints: 3,
          middleLineAt: 2,
          textStyle: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ));
  }
}
