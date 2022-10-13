import 'package:copas/domain/entities/card_entity.dart';
import 'package:copas/domain/entities/game_phases.dart';
import 'package:copas/domain/entities/hand_entity.dart';
import 'package:copas/interface/controllers/game_controller.dart';
import 'package:copas/interface/controllers/hand_controller.dart';
import 'package:copas/interface/game_screen.dart';
import 'package:copas/interface/widgets/card_back.dart';
import 'package:copas/interface/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlayerHandWidget extends HookConsumerWidget {
  const PlayerHandWidget({
    Key? key,
    required this.playerId,
  }) : super(key: key);

  final int playerId;

  @override
  Widget build(BuildContext context, ref) {
    final hand = ref.watch(handProvider(playerId));
    final handNotifier = ref.watch(handProvider(playerId).notifier);
    final matchPhase = ref.watch(matchProvider);
    final turnPhase = ref.watch(turnPhaseProvider);
    return HandWidget(
      hand: hand,
      isPlayer: playerId == 1,
      onCardClick: playerId == 1
          ? (card) {
              if (matchPhase == MatchPhase.playing &&
                  turnPhase == TurnPhase.start) {
                ref.read(cardsToPassProvider.notifier).addCard(card);
              }
            }
          : null,
    );
  }
}

class HandWidget extends HookConsumerWidget {
  const HandWidget({
    super.key,
    required this.hand,
    this.onCardClick,
    required this.isPlayer,
  });

  final HandEntity hand;
  final Function(CardEntity card)? onCardClick;
  final bool isPlayer;

  List<Widget> handCards(
    CardEntity? selectedCard,
    WidgetRef ref,
  ) {
    var sortedHand = [...hand.cards];
    sortedHand.sort(
      (a, b) => a.value.value.compareTo(b.value.value),
    );
    sortedHand.sort((a, b) => a.symbol.order.compareTo(b.symbol.order));
    var handWidget = sortedHand.map<CardInHand>((e) {
      final index = sortedHand.indexOf(e);
      final double cardAngle = sortedHand.length <= 1
          ? 0.0
          : ((-12.0 * (sortedHand.length / 2)) + (12 * (index + 1)));
      final selectedCard = ref.watch(selectedCardProvider);
      final isSelected = selectedCard == e;
      return CardInHand(
        card: e,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedRotation(
            duration: const Duration(milliseconds: 150),
            alignment: Alignment.bottomCenter,
            turns: cardAngle / 360,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 150),
              offset: isSelected ? const Offset(-0.1, -0.1) : Offset.zero,
              child: SizedCard(
                isSelected: isSelected,
                onCardClick: onCardClick,
                card: e,
                isPlayer: isPlayer,
              ),
            ),
          ),
        ),
      );
    }).toList();

    // if (selectedCard != null) {
    //   final selectedCardInHand = handWidget
    //       .firstWhereOrNull((element) => element.card == selectedCard);
    //   if (selectedCardInHand != null) {
    //     handWidget.add(selectedCardInHand);
    //   }
    // }

    return handWidget.map((e) => e.child).toList();
  }

  @override
  Widget build(BuildContext context, ref) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        clipBehavior: Clip.antiAlias,
        fit: StackFit.expand,
        children: handCards(
          ref.watch(selectedCardProvider),
          ref,
        ),
      );
    });
  }
}

class SizedCard extends HookConsumerWidget {
  const SizedCard({
    Key? key,
    required this.isSelected,
    this.onCardClick,
    required this.card,
    required this.isPlayer,
  }) : super(key: key);

  final bool isSelected;
  final Function(CardEntity card)? onCardClick;
  final CardEntity card;
  final bool isPlayer;

  @override
  Widget build(BuildContext context, ref) {
    final cardSize = ref.watch(cardSizeProvider);
    return SizedBox(
      width: cardSize.width,
      height: cardSize.height,
      child: MouseRegion(
        onEnter: isPlayer
            ? (event) {
                if (!isSelected) {
                  ref.read(selectedCardProvider.notifier).state = card;
                }
              }
            : null,
        onExit: isPlayer
            ? ((event) {
                if (isSelected) {
                  ref.read(selectedCardProvider.notifier).state = null;
                }
              })
            : null,
        child: isPlayer
            ? CardWidget(
                card: card,
                onCardTap: onCardClick,
                isHover: isSelected,
              )
            : CardBackWidget(
                cardSize: cardSize,
              ),
      ),
    );
  }
}

class CardInHand {
  final CardEntity card;
  final Widget child;
  CardInHand({
    required this.card,
    required this.child,
  });
}
