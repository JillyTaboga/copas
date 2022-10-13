import 'package:flutter/material.dart';

class CopasPainter extends CustomPainter {
  const CopasPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const color = Colors.red;
    final mid = size.width / 2;
    final heartHeight = size.height / 3;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()..moveTo(0, heartHeight);
    path.cubicTo(0, 0, mid, 0, mid, heartHeight);
    path.cubicTo(mid, 0, size.width, 0, size.width, heartHeight);
    path.quadraticBezierTo(size.width, size.height / 5 * 3, mid, size.height);
    path.quadraticBezierTo(0, size.height / 5 * 3, 0, heartHeight);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CopasPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CopasPainter oldDelegate) => false;
}
