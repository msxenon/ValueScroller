library scrollervaluepicker;

import 'package:flutter/material.dart';
import 'package:scrollervaluepicker/painters.dart';


const tickSpacing = 5.0;

class ValueScroller extends CustomScrollPainter {
  final int divisions;
  final double initalValue;
  final double screenWidth;
  final Color smallTickColor;
  final Color bigTickColor;

  double min;
  double max;

  Paint _largeTickPaint = new Paint();
  Paint _smallTickPaint = new Paint();
  Function(double) onChangeValue;
  double difference ;
  ValueScroller(
      this.screenWidth,
      {
        this.smallTickColor:Colors.white30,
        this.bigTickColor:Colors.white,
        this.initalValue,
        this.onChangeValue,
        this.divisions : 5,
        this.min : 0,
        this.max : 100,
      })
      : assert(initalValue >= min && initalValue <= max),
        super(initalPos:_getInitialLength(initalValue,tickSpacing),
        size: new Size(_computeSize(min, max, divisions,screenWidth), 60.0),
      ) {
    difference =   (max - min)/divisions  ;
    _largeTickPaint.color = bigTickColor;
    _largeTickPaint.strokeWidth = 1;

    _smallTickPaint.color = smallTickColor;
    _smallTickPaint.strokeWidth = 1.0;
    _paint = Paint();
    _paint.color = Colors.transparent;
  }

  Paint _paint;
  @override
  void paint(Canvas canvas, Size size, Rect region) {
    var rect = Offset.zero & size;

    // Extend drawing window to compensate for element sizes
    var extend = _largeTickPaint.strokeWidth / 2.0;

    // Calculate from which Tick we should start drawing
    var tick = ((region.left - extend) / tickSpacing).ceil();

    var startOffset = tick * tickSpacing;
    var o1 = new Offset(startOffset, 20);
    var o2 = new Offset(startOffset, rect.height - 20);

    while (o1.dx < region.right + extend && tick <= (max-min)) {
      Paint p = tick % 5 == 0 ? _largeTickPaint : _smallTickPaint;

      canvas.drawLine(o1, o2, p);
      o1 = o1.translate(tickSpacing, 0.0);
      o2 = o2.translate(tickSpacing, 0.0);

      tick++;

    }
    canvas.drawLine(o1, o2+Offset(screenWidth/2,200), _paint);
  }
  var _currentVal = 0.0;
  @override
  void onChange(double v) {
    var x = ((v / (divisions)))+min;
    if(x == _currentVal)
      return;
    if(x < min)
      x = min;
    else if(x > max)
      x = max;
    this.onChangeValue(x);
  }

  static double _getInitialLength(double initVal,double tickSpace) {
    return initVal * tickSpace;
  }

}

double _computeSize(double minValue, double maxValue, int divisions,double screenWidth) {
  return (maxValue - minValue) * divisions  +screenWidth/2;
}