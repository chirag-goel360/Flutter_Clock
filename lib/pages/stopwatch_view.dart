import 'package:flutter/material.dart';
import 'dart:math' as math;

class StopWatchPainter extends CustomPainter {
  final hourTickMarkLength = 12.0;
  final minuteTickMarkLength = 6.0;
  final hourTickMarkWidth = 3.0;
  final minuteTickMarkWidth = 1.0;
  Color lineColor;
  Color completeColor;
  int hundreds;
  int seconds;
  int minutes;
  int hours;
  double width;
  Paint linePainter;

  StopWatchPainter({
    this.lineColor,
    this.completeColor,
    this.hundreds,
    this.seconds,
    this.minutes,
    this.hours,
    this.width,
    this.linePainter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double mainCenter = size.width / 2;
    linePainter = Paint()
      ..color = Colors.teal
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.translate(
      mainCenter,
      mainCenter,
    );
    double markLength;
    for (int i = 0; i < 60; i++) {
      if (i % 5 == 0) {
        markLength = hourTickMarkLength;
        linePainter.strokeWidth = hourTickMarkWidth;
      } else {
        markLength = minuteTickMarkLength;
        linePainter.strokeWidth = minuteTickMarkWidth;
      }
      canvas.drawLine(
        Offset(
          0,
          -(mainCenter) + width * 4,
        ),
        Offset(
          0,
          -(mainCenter) + width * 4 + markLength,
        ),
        linePainter,
      );
      canvas.rotate(
        (2 * math.pi) / 60,
      );
    }
    canvas.translate(
      -mainCenter,
      -mainCenter,
    );
    Offset center = Offset(
      mainCenter,
      mainCenter,
    );
    double radiusSeconds = mainCenter - (width * 3);
    double radiusMinutes = mainCenter - (width * 1.5);
    double radiusHours = mainCenter;
    double radian = math.pi / 180;
    Paint line = new Paint()
      ..color = Colors.blueAccent
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    double arcAngleSeconds = (radian) * ((seconds + (hundreds / 100)) * 6);
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radiusSeconds,
      ),
      -math.pi / 2,
      arcAngleSeconds,
      false,
      line,
    );
    line.color = Colors.yellow;
    double arcAngleMinutes = (radian) * (minutes * 6);
    canvas.drawArc(
      new Rect.fromCircle(
        center: center,
        radius: radiusMinutes,
      ),
      -math.pi / 2,
      arcAngleMinutes,
      false,
      line,
    );
    line.color = Colors.green;
    double arcAngleHours = (radian) * (hours * 30);
    canvas.drawArc(
      new Rect.fromCircle(
        center: center,
        radius: radiusHours,
      ),
      -math.pi / 2,
      arcAngleHours,
      false,
      line,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
