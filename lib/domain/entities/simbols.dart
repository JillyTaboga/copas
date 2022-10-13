import 'package:copas/interface/painters/clubs_painter.dart';
import 'package:copas/interface/painters/copas_painters.dart';
import 'package:copas/interface/painters/diamon_painter.dart';
import 'package:copas/interface/painters/spades_painter.dart';
import 'package:flutter/material.dart';

enum Symbol {
  heart(Colors.red, CopasPainter()),
  spades(Colors.blue, SpadesPainter()),
  diamond(Colors.amber, DiamondPainter()),
  clubs(Colors.black, ClubsPainter());

  final Color color;
  final CustomPainter painter;

  const Symbol(this.color, this.painter);
}
