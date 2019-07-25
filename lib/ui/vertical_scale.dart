import 'package:flutter/material.dart';
import 'package:height_weight_scale/model/measurement_line.dart';

typedef void ScaleChangedCallback(int scalePoints);

class VerticalScale extends StatefulWidget {
  final int maxValue;
  final ScrollController scaleController;
  final ScaleChangedCallback onChanged;
  final Color scaleColor;
  final Color lineColor;
  final TextStyle textStyle;
  final int linesBetweenTwoPoints;
  final int middleLineAt;
  final Widget pointer;

  const VerticalScale(
      {Key key,
      @required this.maxValue,
      @required this.scaleController,
      this.onChanged,
      this.scaleColor = Colors.tealAccent,
      this.lineColor = Colors.black54,
      this.textStyle = const TextStyle(fontSize: 25, color: Colors.black54),
      this.linesBetweenTwoPoints = 9,
      this.middleLineAt = 5,
      this.pointer})
      : assert(maxValue != null,
            "maxValue cannot be null. This is used to set scale limit. i.e maxValue=10"),
        assert(scaleController != null,
            "scaleController cannot be null. This is used to control the behaviour of scale like reading current scale point, move to particular point in scale etc. Try giving value like scaleController: ScrollController(initialScrollOffset: 0)"),
        super(key: key);

  @override
  _VerticalScaleState createState() => _VerticalScaleState();
}

class _VerticalScaleState extends State<VerticalScale> {
  List<MeasurementLine> measurementLineList = List<MeasurementLine>();

  @override
  void initState() {
    super.initState();
    _createListOfLinesToDraw();
    widget.scaleController.addListener(_scaleScrollListener);
  }

  @override
  void dispose() {
    widget.scaleController.removeListener(_scaleScrollListener);
    widget.scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      decoration: BoxDecoration(color: widget.scaleColor),
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.46 + 17),
            child: widget.pointer ??
                Container(
                  height: 3,
                  width: 90,
                  decoration:
                      BoxDecoration(color: Colors.redAccent.withOpacity(0.7)),
                ),
          ),
          ListView.builder(
            physics: BouncingScrollPhysics(),
            controller: widget.scaleController,
            itemCount: measurementLineList.length,
            padding: EdgeInsets.only(
                left: 5, top: MediaQuery.of(context).size.height * 0.46),
            itemBuilder: (context, index) {
              final mLine = measurementLineList[index];
              if (mLine.type == Line.big) {
                return Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      top: 5,
                      left: 15,
                      child: Text(
                        '${mLine.value}',
                        style: widget.textStyle,
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
                          width: 40,
                          decoration: BoxDecoration(color: widget.lineColor),
                        ),
                      ],
                    )
                  ],
                );
              } else if (measurementLineList[index].type == Line.small) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      height: 19,
                    ),
                    Container(
                      height: 1,
                      width: 20,
                      decoration: BoxDecoration(color: widget.lineColor),
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
                      width: 27,
                      decoration: BoxDecoration(color: widget.lineColor),
                    ),
                  ],
                );
              }
            },
          )
        ],
      ),
    );
  }

  void _createListOfLinesToDraw() {
    for (int i = 0; i <= widget.maxValue; i++) {
      measurementLineList.add(MeasurementLine(type: Line.big, value: i));
      for (int j = 1; j <= widget.linesBetweenTwoPoints; j++) {
        measurementLineList.add(j != widget.middleLineAt
            ? MeasurementLine(type: Line.small, value: i)
            : MeasurementLine(type: Line.medium, value: i));
      }
    }
  }

  _scaleScrollListener() {
    widget.onChanged(widget.scaleController.offset.toInt());
  }
}
