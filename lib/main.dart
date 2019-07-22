import 'package:flutter/material.dart';
import 'package:height_weight_scale/ui/height_weight_scale.dart';

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
        home: SafeArea(child: HeightWeightScalePage()));
  }
}
