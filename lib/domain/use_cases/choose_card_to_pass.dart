import 'dart:math';

import 'package:collection/collection.dart';
import 'package:copas/domain/entities/card_entity.dart';
import 'package:copas/domain/entities/card_values.dart';
import 'package:copas/domain/entities/hand_entity.dart';
import 'package:copas/domain/entities/simbols.dart';
import 'package:copas/interface/controllers/game_controller.dart';
import 'package:copas/interface/controllers/hand_controller.dart';
import 'package:copas/interface/controllers/turn_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

  static _greaterCardFromManyDecks(List<List<CardEntity>> decks) {
    decks.sort((a, b) => a.length.compareTo(b.length));
    decks.first.sort((a, b) => a.value.value.compareTo(b.value.value));
    return decks.first.last;
  }

  static playACard(WidgetRef ref) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final currentPlayer = ref.read(turnProvider);
    final playNotifier = ref.read(cardsInTableProvider.notifier);

    play(CardEntity card) {
      playNotifier.playCard(currentPlayer, card);
      return;
    }

    final currentHand = ref.read(handProvider(currentPlayer));
    if (currentHand.hasStart()) {
      play(currentHand.cards.firstWhere((element) =>
          element.symbol == Symbol.clubs && element.value == CardValue.two));
      return;
    }
    final currentTable = ref.read(cardsInTableProvider);
    final heartsBroken = ref.read(heartsBrokenProvider);
    final tableSymbol = ref.read(tableSymbolProvider);

    final queen =
        currentHand.cards.firstWhereOrNull((element) => element.points == 12);
    final heartsCards = currentHand.cards
        .where((element) => element.symbol == Symbol.heart)
        .toList();
    final spadesCards = currentHand.cards
        .where((element) => element.symbol == Symbol.spades)
        .toList();
    final clubsCards = currentHand.cards
        .where((element) => element.symbol == Symbol.clubs)
        .toList();
    final diamondsCards = currentHand.cards
        .where((element) => element.symbol == Symbol.diamond)
        .toList();
    final badSpades =
        spadesCards.where((element) => element.value.value > 12).toList();
    heartsCards.sort((a, b) => a.value.value.compareTo(b.value.value));
    spadesCards.sort((a, b) => a.value.value.compareTo(b.value.value));
    clubsCards.sort((a, b) => a.value.value.compareTo(b.value.value));
    diamondsCards.sort((a, b) => a.value.value.compareTo(b.value.value));
    badSpades.sort((a, b) => a.value.value.compareTo(b.value.value));
    clubsCards.sort((a, b) => a.value.value.compareTo(b.value.value));

    if (tableSymbol != null) {
      final hasSymbol =
          currentHand.cards.any((element) => element.symbol == tableSymbol);
      if (hasSymbol) {
        final possibleDeck = currentHand.cards
            .where((element) => element.symbol == tableSymbol)
            .toList();
        possibleDeck.sort((a, b) => a.value.value.compareTo(b.value.value));
        final isTheLast = currentTable.length == 3;
        final hasPointInTable =
            currentTable.any((element) => element.card.points > 0);
        if (isTheLast && !hasPointInTable) {
          play(possibleDeck.last);
          return;
        }
        final inTableSameColor = currentTable
            .where((element) => element.card.symbol == tableSymbol)
            .toList();
        inTableSameColor
            .sort((a, b) => a.card.value.value.compareTo(b.card.value.value));
        final lowCards = possibleDeck
            .where((element) =>
                element.value.value < inTableSameColor.last.card.value.value)
            .toList();
        if (lowCards.isNotEmpty) {
          play(lowCards.last);
          return;
        }
        if (lowCards.isEmpty) {
          play(possibleDeck.first);
          return;
        }
      } else {
        if (queen != null) {
          play(queen);
          return;
        }
        if (badSpades.isNotEmpty) {
          play(badSpades.last);
          return;
        }
        if ((heartsBroken || currentHand.cards.length > heartsCards.length) &&
            heartsCards.isNotEmpty) {
          play(
            heartsCards.last,
          );
          return;
        }
        play(
          _greaterCardFromManyDecks([
            spadesCards,
            diamondsCards,
            clubsCards,
          ]),
        );
        return;
      }
    } else {
      play(
        _greaterCardFromManyDecks([
          spadesCards,
          diamondsCards,
          clubsCards,
        ]),
      );
    }
  }
}
