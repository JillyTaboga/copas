import 'package:flutter/material.dart';

class SpadesPainter extends CustomPainter {
  const SpadesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    final mid = size.width / 2;
    final spadesHeight = size.height / 3 * 2;

    final path2 = Path()..moveTo(0, spadesHeight);
    path2.cubicTo(0, size.height, mid, size.height, mid, spadesHeight);
    path2.cubicTo(
        mid, size.height, size.width, size.height, size.width, spadesHeight);
    path2.quadraticBezierTo(size.width / 2, 0, mid, 0);
    path2.quadraticBezierTo(size.width / 2, 0, 0, spadesHeight);

    canvas.drawPath(path2, paint);

    final path = Path()
      ..moveTo(
        size.width / 2,
        size.height / 2,
      );
    path.quadraticBezierTo(
      mid,
      size.height,
      size.width / 3,
      size.height,
    );
    path.lineTo(
      size.width / 3 * 2,
      size.height,
    );
    path.quadraticBezierTo(
      mid,
      size.height,
      size.width / 2,
      size.height / 3,
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(SpadesPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(SpadesPainter oldDelegate) => false;
}
