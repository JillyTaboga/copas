import 'dart:math';

import 'package:copas/domain/entities/card_entity.dart';
import 'package:copas/domain/entities/hand_entity.dart';
import 'package:copas/domain/entities/simbols.dart';

class CpuAi {
  static List<CardEntity> chooseCardToPass(HandEntity hand) {
    List<CardEntity> cardsToPass = [];

    final cards = hand.cards;
    final spadesCards =
        cards.where((element) => element.symbol == Symbol.spades);
    final lowSpades =
        spadesCards.where((element) => element.value.value < 11).toList();
    final hightSpades =
        spadesCards.where((element) => element.value.value >= 11).toList();

    final heartsCards =
        cards.where((element) => element.symbol == Symbol.heart);
    final lowHeartsCards =
        heartsCards.where((element) => element.value.value < 7).toList();
    final hightHearts =
        heartsCards.where((element) => element.value.value >= 7).toList();

    final clubsCards = cards.where((element) => element.symbol == Symbol.clubs);
    final diamonds = cards.where((element) => element.symbol == Symbol.diamond);

    final hasTheQueen = spadesCards.any((element) => element.value.value == 11);

    if (hasTheQueen && spadesCards.length < 4) {
      cardsToPass.addAll(
          spadesCards.where((element) => element.value.value >= 11).toList());
    }

    if (!hasTheQueen && hightSpades.isNotEmpty && lowSpades.length < 3) {
      cardsToPass.addAll(hightSpades);
    }

    if (hightHearts.isNotEmpty && lowHeartsCards.length < 3) {
      cardsToPass.addAll(hightHearts);
    }

    if (heartsCards.length < 4) {
      cardsToPass.addAll(heartsCards);
    }
    if (spadesCards.length < 4) {
      cardsToPass.addAll(heartsCards);
    }
    if (clubsCards.length < 4) {
      cardsToPass.addAll(heartsCards);
    }
    if (diamonds.length < 4) {
      cardsToPass.addAll(heartsCards);
    }

    while (cardsToPass.toSet().toList().length < 3) {
      cardsToPass.add(cards[Random().nextInt(cards.length)]);
    }

    final realCardsToPass = cardsToPass.toSet().toList().sublist(0, 3);
    return realCardsToPass;
  }
}
