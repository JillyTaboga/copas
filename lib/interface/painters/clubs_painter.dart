import 'package:copas/domain/entities/simbols.dart';
import 'package:flutter/material.dart';

class ClubsPainter extends CustomPainter {
  const ClubsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final color = Symbol.clubs.color;
    final mid = size.width / 2;
    final clubsHeight = size.height / 2;
    final radius = size.width / 3 / 2;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 3, clubsHeight),
      radius,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width / 2, clubsHeight / 2),
      radius,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width / 3 * 2, clubsHeight),
      radius,
      paint,
    );
    final path = Path()
      ..moveTo(
        size.height / 2,
        clubsHeight,
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
  bool shouldRepaint(ClubsPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(ClubsPainter oldDelegate) => false;
}
