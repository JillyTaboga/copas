import 'package:copas/interface/painters/copas_painters.dart';
import 'package:flutter/material.dart';

enum Symbol {
  heart(
    Colors.red,
    () => CopasPainter(),
  ),
  spades(Colors.blue),
  diamond(Colors.amber),
  clubs(Colors.black);

  final Color color;
  final CustomPainter Function() painter;

  const Symbol(this.color, this.painter);
}
