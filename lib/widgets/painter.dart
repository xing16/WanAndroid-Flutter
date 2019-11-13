import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class MyPointer extends CustomPainter {
  Paint mPaint = new Paint()
    ..strokeWidth = 2
    ..color = Colors.red
    ..isAntiAlias = true;

  Paint bgPaint = new Paint()
    ..strokeWidth = 2
    ..color = Colors.white30
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    canvas.saveLayer(
        Rect.fromCircle(
          center: Offset(0, 0),
          radius: size.width / 2,
        ),
        mPaint);
    canvas.drawCircle(Offset(0, 0), size.width / 2, mPaint);
    mPaint
      ..color = Colors.cyan
      ..strokeWidth = 2;
    // 横线
    canvas.drawLine(
        Offset(-size.width / 2, 0), Offset(size.width / 2, 0), mPaint);
    // 竖线
    canvas.drawLine(
        Offset(0, -size.height / 2), Offset(0, size.height / 2), mPaint);

//    ui.ParagraphBuilder pb = new ui.ParagraphBuilder(ui.ParagraphStyle(
//      textAlign: TextAlign.left,
//    ))
//      ..pushStyle(ui.TextStyle(
//        color: Colors.white,
//        fontSize: 36,
//        fontWeight: FontWeight.normal,
//        textBaseline: TextBaseline.alphabetic,
//      ))
//      ..addText("0099")
//      ..pushStyle(ui.TextStyle(
//        fontSize: 22,
//        textBaseline: TextBaseline.alphabetic,
//      ))
//      ..addText("分");
//
//    ui.ParagraphConstraints pc = ui.ParagraphConstraints(width: 120);
//    ui.Paragraph paragraph = pb.build()..layout(pc);
//    var textHeight = paragraph.height;
//    canvas.drawParagraph(paragraph, new Offset(-pc.width / 2, -textHeight / 2));

    TextPainter textPainter = new TextPainter(
      text: TextSpan(
        children: [
          TextSpan(
            text: "中国我爱你",
            style: TextStyle(
              color: Colors.green,
              fontSize: 30,
            ),
          ),
          TextSpan(
            text: " 分",
            style: TextStyle(
              color: Colors.green,
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
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
