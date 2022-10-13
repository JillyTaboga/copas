import 'dart:math';

import 'package:copas/data/cards_data.dart';
import 'package:copas/domain/entities/card_entity.dart';
import 'package:copas/domain/entities/hand_entity.dart';
import 'package:copas/interface/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameScreen extends HookConsumerWidget {
  const GameScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          color: Colors.yellow,
          width: constraints.maxWidth,
          height: 300,
          child: HandWidget(
            hand: ref.watch(handProvider),
            width: constraints.maxWidth,
            onCardClick: (card) {
              final currentHand = ref.read(handProvider);
              var newCards = [...currentHand.cards];
              newCards.remove(card);
              ref.read(handProvider.notifier).state =
                  currentHand.copyWith(cards: newCards);
            },
          ),
        );
      }),
    );
  }
}

final handProvider = StateProvider<HandEntity>((ref) {
  return HandEntity(
    handSize: 12,
    cards: randomDeck().sublist(0, 12),
  );
});

class HandWidget extends StatelessWidget {
  const HandWidget({
    super.key,
    required this.hand,
    required this.width,
    required this.onCardClick,
  });

  final HandEntity hand;
  final double width;
  final Function(CardEntity card) onCardClick;

  @override
  Widget build(BuildContext context) {
    var sortedHand = [...hand.cards];
    sortedHand.sort(
      (a, b) => a.value.value.compareTo(b.value.value),
    );
    sortedHand.sort((a, b) => a.symbol.hashCode.compareTo(b.symbol.hashCode));
    return CustomMultiChildLayout(
      delegate: HandDelegate(hand),
      children: sortedHand
          .map((e) => LayoutId(
                id: sortedHand.indexOf(e),
                child: Transform.rotate(
                  alignment: Alignment.bottomLeft,
                  angle: sortedHand.length < 2
                      ? 0
                      : (-45 +
                              (sortedHand.indexOf(e) *
                                  (90 / (sortedHand.length)))) *
                          pi /
                          180,
                  child: InkWell(
                    onTap: () {
                      onCardClick(e);
                    },
                    child: CardWidget(
                      card: e,
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class HandDelegate extends MultiChildLayoutDelegate {
  HandDelegate(this.hand);
  final HandEntity hand;
  @override
  void performLayout(Size size) {
    for (int n = 0; n < hand.cards.length; n++) {
      final card = hand.cards[n];
      final cardHeight = size.height / 3 * 2;
      final radius = (size.width / hand.cards.length * 1.5) / 2;
      final cardSize = layoutChild(
          n,
          BoxConstraints(
            maxHeight: cardHeight,
          ));
      if (hand.cards.length <= 1) {
        positionChild(n, const Offset(0, 0));
        return;
      }
      final cardAngle =
          ((hand.cards.length * 10) - (n * (10 * hand.cards.length))) *
              pi /
              180;
      final x = radius * cos(cardAngle) + (size.width / 2);
      final y = radius * (sin(cardAngle) * -1) + (size.width / 2);
      positionChild(n, Offset(x, y));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}
