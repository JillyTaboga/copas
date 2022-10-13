import 'package:copas/interface/painters/clubs_painter.dart';
import 'package:copas/interface/painters/copas_painters.dart';
import 'package:copas/interface/painters/diamon_painter.dart';
import 'package:copas/interface/painters/spades_painter.dart';
import 'package:flutter/material.dart';

enum Symbol {
  heart(Colors.red, CopasPainter(), 4),
  spades(Colors.black, SpadesPainter(), 3),
  diamond(Colors.blue, DiamondPainter(), 2),
  clubs(Colors.green, ClubsPainter(), 1);

  final Color color;
  final CustomPainter painter;
  final int order;

  const Symbol(this.color, this.painter, this.order);
}
