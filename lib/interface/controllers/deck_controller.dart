import 'package:copas/data/cards_data.dart';
import 'package:copas/domain/entities/card_entity.dart';
import 'package:copas/domain/entities/hand_entity.dart';
import 'package:copas/interface/controllers/hand_controller.dart';
import 'package:copas/interface/controllers/turn_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final playerToCatchProvider = Provider<int>((ref) {
  final currentTable = ref.watch(cardsInTableProvider);
  final tableSymbol = ref.watch(tableSymbolProvider);
  currentTable.sort((a, b) => a.card.value.value.compareTo(b.card.value.value));
  final highCard = currentTable
      .where((element) => tableSymbol == element.card.symbol)
      .toList();
  if (highCard.isEmpty) {
    return 0;
  } else {
    return highCard.last.playedBy;
  }
});

final cardsCatchedProvider = StateNotifierProvider.family<CardsCatchedNotifier,
    List<List<CardEntity>>, int>((ref, player) {
  return CardsCatchedNotifier();
});

class CardsCatchedNotifier extends StateNotifier<List<List<CardEntity>>> {
  CardsCatchedNotifier() : super([]);

  add(List<CardEntity> cards) {
    state = [...state, cards];
  }

  clear() {
    state = [];
  }
}

final deckProvider =
    StateNotifierProvider<DeckNotifier, List<DealingCard>>((ref) {
  return DeckNotifier(ref);
});

class DeckNotifier extends StateNotifier<List<DealingCard>> {
  DeckNotifier(this.ref)
      : super(randomDeck().map((e) => DealingCard(card: e)).toList());

  final Ref ref;

  newHand() async {
    state = randomDeck().map((e) => DealingCard(card: e)).toList();
    await distrubute();
    ref.read(turnProvider.notifier).setStartPlayer();
  }

  distrubute() async {
    final lastingCards = [...state];
    int dealing = 1;
    while (lastingCards.isNotEmpty) {
      var currentCard = lastingCards.first;
      var stateCards = [...state];
      final index = stateCards.indexOf(currentCard);
      stateCards.removeAt(index);
      currentCard = currentCard.copyWith(
        position: dealing,
      );
      stateCards.insert(index, currentCard);
      lastingCards.removeAt(0);
      await Future.delayed(const Duration(milliseconds: 80));
      state = stateCards;
      if (dealing == 4) {
        dealing = 1;
      } else {
        dealing++;
      }
    }
    ref.read(handProvider(1).notifier).state = HandEntity(
      cards: state
          .where((element) => element.position == 1)
          .toList()
          .map((e) => e.card)
          .toList(),
    );
    ref.read(handProvider(2).notifier).state = HandEntity(
      cards: state
          .where((element) => element.position == 2)
          .toList()
          .map((e) => e.card)
          .toList(),
    );
    ref.read(handProvider(3).notifier).state = HandEntity(
      cards: state
          .where((element) => element.position == 3)
          .toList()
          .map((e) => e.card)
          .toList(),
    );
    ref.read(handProvider(4).notifier).state = HandEntity(
      cards: state
          .where((element) => element.position == 4)
          .toList()
          .map((e) => e.card)
          .toList(),
    );
  }
}

class DealingCard {
  final int position;
  final CardEntity card;
  DealingCard({
    this.position = 0,
    required this.card,
  });

  DealingCard copyWith({
    int? position,
    CardEntity? card,
  }) {
    return DealingCard(
      position: position ?? this.position,
      card: card ?? this.card,
    );
  }
}
