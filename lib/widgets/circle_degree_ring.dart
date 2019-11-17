import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleDegreeRing extends CustomPainter {
  Paint mPaint = new Paint()
    ..color = Colors.white54
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  var tipString = const ["加油", "厉害", "很棒"];

  double startAngle = 5 * pi / 6;
  double sweepAngle = 4 * pi / 3; // 240度
  double percent;
  double gap = 2;
  double centerRingWidth = 16;
  TextPainter textPainter;
  int curPoints;
  int maxPoints;

  Offset pointOffset;

  CircleDegreeRing(this.curPoints, this.maxPoints) {
    percent = curPoints / maxPoints > 1 ? 1 : curPoints / maxPoints;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制半径 = (宽高最小值 - strokeWidth) / 2
    double radius = min(size.width, size.height) / 2 - mPaint.strokeWidth / 2;
    canvas.save();
    // 平移到中心
    canvas.translate(size.width / 2, size.height / 2);

    // 绘制圆点
    mPaint.style = PaintingStyle.fill;
    mPaint.color = Colors.white24;
    pointOffset = new Offset(
        cos(1 / 2 * pi + sweepAngle / 2 - sweepAngle * percent) * radius,
        -sin(1 / 2 * pi + sweepAngle / 2 - sweepAngle * percent) * radius);
    canvas.drawCircle(pointOffset, 12, mPaint);
    mPaint.color = Colors.white38;
    canvas.drawCircle(pointOffset, 8, mPaint);
    mPaint.color = Colors.white;
    canvas.drawCircle(pointOffset, 3, mPaint);

    // 已达到的刻度
    mPaint.color = Colors.white;
    mPaint.style = PaintingStyle.stroke;
    mPaint.strokeWidth = 3;
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

    // 绘制中间圆环
    // 以达到刻度
    mPaint.strokeWidth = centerRingWidth;
    mPaint.color = Colors.white54;
    canvas.drawArc(
        Rect.fromCircle(center: Offset(0, 0), radius: radius - centerRingWidth),
        startAngle,
        sweepAngle,
        false,
        mPaint);
    mPaint.strokeWidth = 2;
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(0, 0), radius: radius - centerRingWidth * 3 / 2 - 4),
        startAngle,
        sweepAngle,
        false,
        mPaint);

    // 绘制中间分数
    textPainter = new TextPainter(
      text: TextSpan(
        children: [
          TextSpan(
            text: curPoints.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
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

    // 绘制中间分数提示语
    textPainter = new TextPainter(
      text: TextSpan(
        children: [
          TextSpan(
            text: getTipString(curPoints),
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

    // 绘制刻度线
    canvas.rotate(pi * 4 / 3);
    double degreeCount = 8;
    mPaint.strokeWidth = 2;
    for (int i = 0; i <= degreeCount; i++) {
      // 刻度线
      canvas.drawLine(
          Offset(0, -radius + centerRingWidth / 2),
          Offset(0, -radius + centerRingWidth / 2 + centerRingWidth / 2),
          mPaint);
      // 绘制可短文字
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
                fontSize: 12,
              ),
            ),
          ],
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        maxLines: 1,
      );
      textPainter.layout();
      textPainter.paint(canvas, new Offset(0, -radius + centerRingWidth * 2));
      canvas.rotate(sweepAngle / degreeCount);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  String getTipString(int coinCount) {
    if (coinCount >= 4000) {
      return "棒极";
    } else if (coinCount >= 3000) {
      return "厉害";
    }
    return "加油";
  }
}
