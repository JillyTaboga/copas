import 'package:copas/domain/entities/card_entity.dart';
import 'package:copas/interface/widgets/card_shadows.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _cardHoverProvider = StateProvider.family<bool, CardEntity>((ref, card) {
  return false;
});

class CardWidget extends HookConsumerWidget {
  const CardWidget({
    Key? key,
    required this.card,
  }) : super(key: key);

  final CardEntity card;

  @override
  Widget build(BuildContext context, ref) {
    return LayoutBuilder(builder: (context, constraints) {
      final widht = constraints.maxHeight * 0.6;
      final height = constraints.maxHeight;
      final isHover = ref.watch(_cardHoverProvider(card));
      final hoverNotifier = ref.watch(_cardHoverProvider(card).notifier);
      return MouseRegion(
        onEnter: (event) {
          if (!isHover) {
            hoverNotifier.state = true;
          }
        },
        onExit: (event) {
          if (isHover) {
            hoverNotifier.state = false;
          }
        },
        child: Container(
          height: height,
          width: widht,
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsets.all(widht / 20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(widht / 10),
            boxShadow: [
              CardShadow(
                onHover: isHover,
                symbol: card.symbol,
                size: widht,
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: widht / 25),
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(widht / 10),
              border: Border.all(color: Colors.black54, width: 0.2),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    card.value.label,
                    style: TextStyle(
                      fontSize: widht / 5,
                      fontWeight: FontWeight.bold,
                      color: card.symbol.color,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SizedBox.square(
                      dimension: widht / 3,
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
                        fontSize: widht / 5,
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
