import 'package:flutter/material.dart';
import 'package:height_weight_scale/ui/example3.dart';

void main() => runApp(HeightWeightScaleDemo());

class HeightWeightScaleDemo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Height Weight Scale Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blueGrey, accentColor: Colors.tealAccent),
        home: SafeArea(child: Example3()));
  }
}
