import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PathPainter extends CustomPainter {
  Paint mPaint = new Paint()
    ..color = Colors.cyan
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height / 2);
//    path.quadraticBezierTo(size.width / 2, size.height, size.width, 0);
    path.cubicTo(size.width / 4, 0, size.width * 3 / 4, size.height, size.width,
        size.height / 2);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, mPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return null;
  }
}
