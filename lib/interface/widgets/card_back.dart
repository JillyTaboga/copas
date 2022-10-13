import 'package:copas/interface/painters/back_painter.dart';
import 'package:flutter/material.dart';

class CardBackWidget extends StatelessWidget {
  const CardBackWidget({
    Key? key,
    required this.cardSize,
  }) : super(key: key);

  final Size cardSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: cardSize.width,
      height: cardSize.height,
      padding: EdgeInsets.all(cardSize.width / 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        boxShadow: kElevationToShadow[2],
        borderRadius: BorderRadius.circular(cardSize.width / 10),
      ),
      child: CustomPaint(
        painter: BackPainter(),
      ),
    );
  }
}
