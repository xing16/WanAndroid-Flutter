import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CircleDegreeRing extends CustomPainter {
  Paint mPaint = new Paint()
    ..color = Colors.white54
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  double startAngle = 5 * pi / 6;
  double sweepAngle = 4 * pi / 3; // 240度
  double progress = 30;
  double gap = 2;
  double centerRingWidth = 12;

  CircleDegreeRing(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    print("size = $size");
    double percent = progress / 100;
    // 半径为控件 = (宽高最小值 - strokeWidth) / 2
    double radius = min(size.width, size.height) / 2 - mPaint.strokeWidth / 2;

    canvas.save();
    // 平移到中心
    canvas.translate(size.width / 2, size.height / 2);
    mPaint.color = Colors.white;
    mPaint.strokeWidth = 3;
    // 已达到的刻度
    canvas.drawArc(Rect.fromCircle(center: Offset(0, 0), radius: radius),
        startAngle, sweepAngle * percent, false, mPaint);
    // 未达到的刻度
    mPaint.strokeWidth = 2;
    mPaint.color = Colors.white54;
    canvas.drawArc(
        Rect.fromCircle(center: Offset(0, 0), radius: radius),
        startAngle + sweepAngle * percent,
        sweepAngle - sweepAngle * percent,
        false,
        mPaint);

    mPaint.strokeWidth = centerRingWidth;
    canvas.drawArc(
        Rect.fromCircle(center: Offset(0, 0), radius: radius - centerRingWidth),
        startAngle,
        sweepAngle,
        false,
        mPaint);

    TextPainter textPainter = new TextPainter(
      text: TextSpan(
        children: [
          TextSpan(
            text: "1001",
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
            ),
          ),
          TextSpan(
            text: "分",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      maxLines: 1,
    );
    textPainter.layout();
    textPainter.paint(
        canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));

    textPainter = new TextPainter(
      text: TextSpan(
        children: [
          TextSpan(
            text: "3 级",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 22,
            ),
          ),
        ],
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      maxLines: 1,
    );
    textPainter.layout();
    textPainter.paint(
        canvas, Offset(-textPainter.width / 2, textPainter.height / 2));

    canvas.rotate(pi * 4 / 3);
    double degreeCount = 8;
    mPaint.strokeWidth = 2;
    for (int i = 0; i <= degreeCount; i++) {
      // 刻度线
      canvas.drawLine(Offset(0, -size.height / 2 + centerRingWidth / 2 + 2),
          Offset(0, -size.height / 2 + centerRingWidth + 3), mPaint);
      String text = (i * 5).toString();
      Path path = new Path();

      canvas.drawPath(path, mPaint);

      textPainter = new TextPainter(
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        maxLines: 1,
      );
      textPainter.layout();
      textPainter.paint(
          canvas, new Offset(0, -size.height / 2 + centerRingWidth * 2));

      canvas.rotate(sweepAngle / degreeCount);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
