import 'package:copas/domain/entities/card_entity.dart';
import 'package:copas/interface/game_screen.dart';
import 'package:copas/interface/widgets/card_shadows.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CardWidget extends HookConsumerWidget {
  const CardWidget({
    Key? key,
    required this.card,
    this.onCardTap,
    required this.isHover,
  }) : super(key: key);

  final CardEntity card;
  final void Function(CardEntity card)? onCardTap;
  final bool isHover;

  @override
  Widget build(BuildContext context, ref) {
    final cardSize = ref.watch(cardSizeProvider);
    return LayoutBuilder(builder: (context, constraints) {
      return InkWell(
        onTap: (() {
          onCardTap?.call(card);
        }),
        child: Container(
          height: cardSize.height,
          width: cardSize.width,
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsets.all(cardSize.width / 20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(cardSize.width / 10),
            boxShadow: [
              CardShadow(
                onHover: isHover,
                symbol: card.symbol,
                size: cardSize.width,
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: cardSize.width / 25),
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(cardSize.width / 10),
              border: Border.all(color: Colors.black54, width: 0.2),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    card.value.label,
                    style: TextStyle(
                      fontSize: cardSize.width / 5,
                      fontWeight: FontWeight.bold,
                      color: card.symbol.color,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox.square(
                    dimension: cardSize.width / 8,
                    child: CustomPaint(
                      painter: card.symbol.painter,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SizedBox.square(
                      dimension: cardSize.width / 3,
                      child: CustomPaint(
                        painter: card.symbol.painter,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Transform.scale(
                    scale: -1,
                    child: SizedBox.square(
                      dimension: cardSize.width / 8,
                      child: CustomPaint(
                        painter: card.symbol.painter,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Transform.scale(
                    scale: -1,
                    child: Text(
                      card.value.label,
                      style: TextStyle(
                        fontSize: cardSize.width / 5,
                        fontWeight: FontWeight.bold,
                        color: card.symbol.color,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
