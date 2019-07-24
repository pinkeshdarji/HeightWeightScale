import 'package:flutter/material.dart';
import 'package:height_weight_scale/model/measurement_line.dart';

typedef void ScaleChangedCallback(int feet, int inch);

class HeightScale extends StatefulWidget {
  final int heightLimitInFeet;
  final ScrollController heightController;
  final ScaleChangedCallback onChanged;

  const HeightScale({
    Key key,
    @required this.heightLimitInFeet,
    @required this.heightController,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _HeightScaleState createState() => _HeightScaleState();
}

class _HeightScaleState extends State<HeightScale> {
  List<MeasurementLine> heightMeasurementLineList = List<MeasurementLine>();

  @override
  void initState() {
    super.initState();
    _fillDataForHeight();
    widget.heightController.addListener(_heightScrollListener);
  }

  @override
  void dispose() {
    widget.heightController.removeListener(_heightScrollListener);
    widget.heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      decoration: BoxDecoration(color: Colors.tealAccent[200]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.46),
            child: RotatedBox(
              quarterTurns: 1,
              child: Image.asset(
                'assets/images/tooltip.png',
                scale: 1,
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            physics: BouncingScrollPhysics(),
            controller: widget.heightController,
            itemCount: heightMeasurementLineList.length,
            padding: EdgeInsets.only(
                left: 5, top: MediaQuery.of(context).size.height * 0.46),
            itemBuilder: (context, index) {
              final mLine = heightMeasurementLineList[index];
              if (mLine.type == Line.big) {
                return Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      top: 4,
                      left: 0,
                      child: Text(
                        '${mLine.value}',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          height: 17,
                        ),
                        Container(
                          height: 3,
                          width: 30,
                          decoration: BoxDecoration(color: Colors.black54),
                        ),
                      ],
                    )
                  ],
                );
              } else if (heightMeasurementLineList[index].type == Line.small) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      height: 19,
                    ),
                    Container(
                      height: 1,
                      width: 20,
                      decoration: BoxDecoration(color: Colors.blueGrey),
                    ),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                      height: 2,
                      width: 30,
                      decoration: BoxDecoration(color: Colors.black54),
                    ),
                  ],
                );
              }
            },
          ))
        ],
      ),
    );
  }

  void _fillDataForHeight() {
    for (int i = 0; i <= widget.heightLimitInFeet; i++) {
      heightMeasurementLineList.add(MeasurementLine(type: Line.big, value: i));
      for (int j = 0; j <= 10; j++) {
        heightMeasurementLineList.add(j != 5
            ? MeasurementLine(type: Line.small, value: i)
            : MeasurementLine(type: Line.medium, value: i));
      }
    }
  }

  _heightScrollListener() {
    debugPrint('${widget.heightController.offset}');
    _heightConvertPixelToFeetAndInchAndReflectOnTextForm(
        widget.heightController.offset.toInt());
  }

  _heightConvertPixelToFeetAndInchAndReflectOnTextForm(int value) {
    int inchOffest = value ~/ 20;
    int feet = inchOffest ~/ 12;
    int inch = inchOffest % 12;
    debugPrint('${feet} feet and ${inch} inch long');
    widget.onChanged(feet, inch);
  }

//  _moveScaleTo() {
//    double moveToPixel = widget.feet * 240 + widget.inch * 20;
//    if (widget.heightController.hasClients) {
//      widget.heightController.animateTo(moveToPixel,
//          duration: Duration(milliseconds: 1000), curve: Curves.fastOutSlowIn);
//    }
//  }
}
