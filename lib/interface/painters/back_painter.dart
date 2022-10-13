import 'package:flutter/material.dart';

class BackPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    const columns = 6;
    const rows = 10;
    final width = size.width / columns;
    final height = size.height / rows;
    final path = Path()
      ..moveTo(0, height / 2)
      ..lineTo(width / 2, 0)
      ..lineTo(width, height / 2)
      ..lineTo(width / 2, height)
      ..close();
    for (int x = 0; x < columns; x++) {
      for (int y = 0; y < rows; y++) {
        final form = path.shift(Offset(x * width, y * height));
        canvas.drawPath(form, paint);
      }
    }
    final borderPaint = Paint()
      ..color = Colors.red.withOpacity(0.5)
      ..style = PaintingStyle.stroke;
    final borderFill = Paint()
      ..color = Colors.red.withOpacity(0.1)
      ..style = PaintingStyle.fill;
    final borderRect = RRect.fromLTRBR(
        0, 0, size.width, size.height, Radius.circular(size.height * 0.6 / 25));
    canvas.drawRRect(borderRect, borderPaint);
    canvas.drawRRect(borderRect, borderFill);
  }

  @override
  bool shouldRepaint(BackPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BackPainter oldDelegate) => false;
}
