import 'dart:math';

import 'package:copas/domain/entities/card_entity.dart';
import 'package:copas/domain/entities/card_values.dart';
import 'package:copas/domain/entities/simbols.dart';

List<CardEntity> allCards() {
  List<CardEntity> cards = [];
  for (final symbol in Symbol.values) {
    for (final value in CardValue.values) {
      cards.add(CardEntity(symbol, value));
    }
  }
  return cards;
}

final List<CardEntity> deck = allCards();

List<CardEntity> randomDeck() {
  var remainCards = [...deck];
  List<CardEntity> randomDeck = [];
  while (remainCards.isNotEmpty) {
    final randomCard = remainCards[Random().nextInt(remainCards.length)];
    randomDeck.add(randomCard);
    remainCards.remove(randomCard);
  }
  return randomDeck;
}
