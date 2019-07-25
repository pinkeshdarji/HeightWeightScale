import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:height_weight_scale/model/measurement_line.dart';

import 'vertical_scale.dart';

class HeightWeightScalePage extends StatefulWidget {
  @override
  _HeightWeightScalePageState createState() => _HeightWeightScalePageState();
}

class _HeightWeightScalePageState extends State<HeightWeightScalePage> {
  ScrollController _weightController;
  ScrollController _heightController;
  List<MeasurementLine> weightMeasurementLineList = List<MeasurementLine>();
  final feetController = TextEditingController();
  final inchController = TextEditingController();
  final kilogramController = TextEditingController();
  final weightLimitInKg = 200;

  double feetValue = 0;
  double inchValue = 0;

  @override
  void initState() {
    super.initState();
    _fillDataForWeight();
    _weightController = ScrollController(initialScrollOffset: 0);
    _heightController = ScrollController(initialScrollOffset: 0);
    _weightController.addListener(_weightScrollListener);
  }

  @override
  void dispose() {
    _weightController.removeListener(_weightScrollListener);
    _weightController.dispose();
    feetController.dispose();
    inchController.dispose();
    kilogramController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Height',
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 100,
                              child: TextField(
                                controller: feetController,
                                style: TextStyle(fontSize: 22),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: '0',
                                    suffixText: 'ft',
                                    border: OutlineInputBorder()),
                                //onSubmitted: _heightChangeScale(),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 100,
                              child: TextField(
                                controller: inchController,
                                style: TextStyle(fontSize: 22),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: '0',
                                    suffixText: 'in',
                                    border: OutlineInputBorder()),
                                //onSubmitted: _heightChangeScale(),
                              ),
                            ),
                          ],
                        ),
                        RaisedButton(
                          onPressed: _heightChangeScale,
                          child: Text('set height'),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Weight',
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 120,
                              child: TextField(
                                controller: kilogramController,
                                style: TextStyle(fontSize: 22),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: '0',
                                    suffixText: 'kg',
                                    border: OutlineInputBorder()),
                                onSubmitted: _weightChangeScale(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  )),
                  Container(
                    height: 90,
                    decoration: BoxDecoration(color: Colors.tealAccent[200]),
                    child: Column(
                      children: <Widget>[
                        RotatedBox(
                          quarterTurns: 2,
                          child: Image.asset(
                            'assets/images/tooltip.png',
                            scale: 1,
                          ),
                        ),
                        Expanded(
                            child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: weightMeasurementLineList.length,
                          scrollDirection: Axis.horizontal,
                          controller: _weightController,
                          padding: EdgeInsets.only(
                              top: 5,
                              left: MediaQuery.of(context).size.width * 0.35),
                          itemBuilder: (context, index) {
                            final mLine = weightMeasurementLineList[index];

                            if (mLine.type == Line.big) {
                              return Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                overflow: Overflow.visible,
                                children: <Widget>[
                                  Positioned(
                                    left: 12,
                                    top: 0,
                                    child: Text(
                                      '${mLine.value}',
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 17,
                                      ),
                                      Container(
                                        width: 3,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.black54),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            } else if (weightMeasurementLineList[index].type ==
                                Line.small) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(
                                    width: 19,
                                  ),
                                  Container(
                                    width: 1,
                                    height: 20,
                                    decoration:
                                        BoxDecoration(color: Colors.blueGrey),
                                  ),
                                ],
                              );
                            } else {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Container(
                                    width: 2,
                                    height: 30,
                                    decoration:
                                        BoxDecoration(color: Colors.black54),
                                  ),
                                ],
                              );
                            }
                          },
                        ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            VerticalScale(
              maxValue: 13,
              scaleController: _heightController,
              scaleColor: Colors.amberAccent,
              lineColor: Colors.purple,
              linesBetweenTwoPoints: 11,
              middleLineAt: 6,
              textStyle: TextStyle(
                  fontSize: 22,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold),
              onChanged: _handleHeightScaleChanged,
            ),
          ],
        ),
      ),
    );
  }

  /// Methods
  void _fillDataForWeight() {
    for (int i = 0; i <= weightLimitInKg; i++) {
      weightMeasurementLineList.add(MeasurementLine(type: Line.big, value: i));
      for (int j = 0; j <= 8; j++) {
        weightMeasurementLineList.add(j != 4
            ? MeasurementLine(type: Line.small, value: i)
            : MeasurementLine(type: Line.medium, value: i));
      }
    }
  }

  _weightScrollListener() {
    debugPrint('${_weightController.offset}');
    _weightConvertPixelToKgReflectOnTextForm(_weightController.offset.toInt());
  }

  _weightConvertPixelToKgReflectOnTextForm(int value) {
    int gram = value ~/ 20;
    double kg = ((gram * 100) / 1000);
    kilogramController.text = kg.toString();
  }

  _heightChangeScale() {
    double moveToFeet = double.tryParse(feetController.text) ?? 0;
    double moveToInch = double.tryParse(inchController.text) ?? 0;
    double moveToPixel = moveToFeet * 240 + moveToInch * 20;
    debugPrint('$moveToPixel');
    if (_heightController.hasClients) {
      _heightController.animateTo(moveToPixel,
          duration: Duration(milliseconds: 1000), curve: Curves.fastOutSlowIn);
    }
  }

  _weightChangeScale() {
    double moveToFeet = double.tryParse(kilogramController.text) ?? 0;
    double moveToPixel = moveToFeet / 0.1 * 20;
    debugPrint('$moveToPixel');
    if (_weightController.hasClients) {
      _weightController.animateTo(moveToPixel,
          duration: Duration(milliseconds: 1000), curve: Curves.fastOutSlowIn);
    }
  }

  void _handleHeightScaleChanged(int scalePoints) {
    int inchOffest = scalePoints ~/ 20;
    int feet = inchOffest ~/ 12;
    int inch = inchOffest % 12;
    debugPrint('${feet} feet and ${inch} inch long');
    setState(() {
      feetController.text = feet.toString();
      inchController.text = inch.toString();
    });
  }
}
