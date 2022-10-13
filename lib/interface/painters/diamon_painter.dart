import 'package:copas/domain/entities/simbols.dart';
import 'package:flutter/material.dart';

class DiamondPainter extends CustomPainter {
  const DiamondPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Symbol.diamond.color
      ..style = PaintingStyle.fill;
    final path = Path()..moveTo(size.width / 2, 0);
    path.lineTo(size.width / 6 * 5, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width / 6, size.height / 2);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(DiamondPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(DiamondPainter oldDelegate) => false;
}
