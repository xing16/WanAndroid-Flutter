import 'package:flutter/material.dart';

class BezierPathPainter extends CustomPainter {
  Paint mPaint = new Paint()
    ..color = Colors.redAccent
    ..isAntiAlias = true;

  Path path = new Path();
  double bigRadius = 30;
  double smallRadius = 20;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);

    path.moveTo(-size.width / 2, -size.height / 2);
    path.lineTo(-size.width / 2, size.height * 3 / 8);

    path.quadraticBezierTo(
        0, size.height / 2, size.width / 2, size.height * 3 / 8);

//    path.cubicTo(size.width / 4, 0, size.width * 3 / 4, size.height, size.width,
//        size.height / 2);
    path.lineTo(size.width / 2, -size.height / 2);
    canvas.drawPath(path, mPaint);

    mPaint.color = Colors.white38;
    canvas.drawCircle(
        new Offset(size.width / 2 - 2 * bigRadius, -size.height / 5),
        bigRadius,
        mPaint);
    canvas.drawCircle(
        new Offset(size.width / 2 - 2 * bigRadius - 30, -size.height / 5 + 10),
        smallRadius,
        mPaint);
    canvas.drawCircle(
        new Offset(-size.width / 2 + 3 * smallRadius,
            -size.height / 2 + 2 * smallRadius),
        smallRadius,
        mPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
