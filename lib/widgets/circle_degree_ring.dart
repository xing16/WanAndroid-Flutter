import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CircleDegreeRing extends CustomPainter {
  Paint mPaint = new Paint()
    ..color = Colors.white54
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;
  double progress = 30;

  CircleDegreeRing(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    print("size = $size");
    mPaint.style = PaintingStyle.stroke;
    double radius = min(size.width, size.height) / 2 - mPaint.strokeWidth / 2;
    double startAngle = 3 * pi / 4;
    double sweepAngle = 3 * pi / 2;
    double percent = progress / 100;
    mPaint.color = Colors.white;
    // 已达到的刻度
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: radius),
        startAngle,
        sweepAngle * percent,
        false,
        mPaint);
    // 未达到的刻度
    mPaint.color = Colors.white54;
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: radius),
        startAngle + sweepAngle * percent,
        sweepAngle - sweepAngle * percent,
        false,
        mPaint);

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(pi * 5 / 4);
    for (int i = 0; i <= 54; i++) {
      if (i < progress / 100 * 54) {
        mPaint.color = Colors.white;
      } else {
        mPaint.color = Colors.white54;
      }
      canvas.drawLine(Offset(0, -size.height / 2 + 10),
          Offset(0, -size.height / 2 + 20), mPaint);
      canvas.rotate(pi / 36);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
