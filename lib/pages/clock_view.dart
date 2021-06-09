import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_clock/constants/theme_data.dart';

class ClockView extends StatefulWidget {
  final double size;

  const ClockView({
    Key key,
    this.size,
  }) : super(key: key);

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  Timer timer;

  @override
  void initState() {
    this.timer = Timer.periodic(
      Duration(
        seconds: 1,
      ),
      (timer) {
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    this.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: widget.size,
        height: widget.size,
        child: Transform.rotate(
          angle: -pi / 2,
          child: CustomPaint(
            painter: ClockPaint(),
          ),
        ),
      ),
    );
  }
}

class ClockPaint extends CustomPainter {
  var dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(
      centerX,
      centerY,
    );
    var radius = min(
      centerX,
      centerY,
    );
    var fillPaintBrush = Paint()..color = CustomColors.clockBackground;
    canvas.drawCircle(
      center,
      radius * 0.75,
      fillPaintBrush,
    );
    var outlinePaintBrush = Paint()
      ..color = CustomColors.clockOutline
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 20;
    canvas.drawCircle(
      center,
      radius * 0.75,
      outlinePaintBrush,
    );
    var centerFillPaintBrush = Paint()..color = CustomColors.clockOutline;
    var secondHandPaintBrush = Paint()
      ..color = CustomColors.secondHandColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 60;
    var minuteHandPaintBrush = Paint()
      ..shader = RadialGradient(
        colors: [
          CustomColors.minuteHandStartColor,
          CustomColors.minuteHandEndColor,
        ],
      ).createShader(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
      )
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 30;
    var hourHandPaintBrush = Paint()
      ..shader = RadialGradient(
        colors: [
          CustomColors.hourHandStartColor,
          CustomColors.hourHandEndColor,
        ],
      ).createShader(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
      )
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 24;
    var seconddegree = dateTime.second * 6 * pi / 180;
    var hourdegree = (dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180;
    var minutedegree = dateTime.minute * 6 * pi / 180;
    var secondHandX = centerX + radius * 0.6 * cos(seconddegree);
    var secondHandY = centerY + radius * 0.6 * sin(seconddegree);
    var hourHandX = centerX + radius * 0.4 * cos(hourdegree);
    var hourHandY = centerY + radius * 0.4 * sin(hourdegree);
    var minuteHandX = centerX + radius * 0.6 * cos(minutedegree);
    var minuteHandY = centerY + radius * 0.6 * sin(minutedegree);
    canvas.drawLine(
      center,
      Offset(
        hourHandX,
        hourHandY,
      ),
      hourHandPaintBrush,
    );
    canvas.drawLine(
      center,
      Offset(
        minuteHandX,
        minuteHandY,
      ),
      minuteHandPaintBrush,
    );
    canvas.drawLine(
      center,
      Offset(
        secondHandX,
        secondHandY,
      ),
      secondHandPaintBrush,
    );
    canvas.drawCircle(
      center,
      radius * 0.12,
      centerFillPaintBrush,
    );
    var dashBrush = Paint()
      ..color = CustomColors.clockOutline
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    var outerCircleRadius = radius;
    var innerCircleRadius = radius * 0.9;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerY + outerCircleRadius * sin(i * pi / 180);
      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerY + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(
        Offset(
          x1,
          y1,
        ),
        Offset(
          x2,
          y2,
        ),
        dashBrush,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
