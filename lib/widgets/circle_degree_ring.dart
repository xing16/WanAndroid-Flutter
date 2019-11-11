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

    mPaint.strokeWidth = 12;
    canvas.drawArc(Rect.fromCircle(center: Offset(0, 0), radius: radius - 12),
        startAngle, sweepAngle, false, mPaint);

    canvas.rotate(pi * 4 / 3);

    double degreeCount = 8;
    mPaint.strokeWidth = 2;
    for (int i = 0; i <= degreeCount; i++) {
      canvas.drawLine(Offset(0, -size.height / 2 + 8),
          Offset(0, -size.height / 2 + 14), mPaint);

      String text = (i * 500).toString();
      ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
        textAlign: TextAlign.center,
        fontStyle: FontStyle.normal,
        fontSize: 12,
      ))
        ..pushStyle(ui.TextStyle(
          color: Colors.white,
        ))
        ..addText(text);
      ui.ParagraphConstraints pc = ui.ParagraphConstraints(width: 30);
      ui.Paragraph paragraph = pb.build()..layout(pc);
      canvas.drawParagraph(paragraph, new Offset(0, -size.height / 2 + 22));
      canvas.rotate(sweepAngle / degreeCount);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
