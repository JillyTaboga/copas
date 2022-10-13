import 'package:copas/domain/entities/simbols.dart';
import 'package:flutter/material.dart';

class CardShadow extends BoxShadow {
  final bool onHover;
  final Symbol symbol;
  final double size;
  CardShadow({
    required this.onHover,
    required this.symbol,
    required this.size,
  }) : super(
          blurRadius: !onHover ? size / 50 : size / 25,
          spreadRadius: !onHover ? size / 50 : size / 25,
          color: !onHover ? Colors.black26 : symbol.color,
        );
}
