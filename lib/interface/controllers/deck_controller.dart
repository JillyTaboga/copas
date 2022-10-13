import 'package:copas/data/cards_data.dart';
import 'package:copas/domain/entities/card_entity.dart';
import 'package:copas/domain/entities/hand_entity.dart';
import 'package:copas/interface/controllers/hand_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final deckProvider =
    StateNotifierProvider<DeckNotifier, List<DealingCard>>((ref) {
  return DeckNotifier(ref);
});

class DeckNotifier extends StateNotifier<List<DealingCard>> {
  DeckNotifier(this.ref)
      : super(randomDeck().map((e) => DealingCard(card: e)).toList());

  final Ref ref;

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
      handSize: 12,
      cards: state
          .where((element) => element.position == 1)
          .toList()
          .map((e) => e.card)
          .toList(),
    );
    ref.read(handProvider(2).notifier).state = HandEntity(
      handSize: 12,
      cards: state
          .where((element) => element.position == 2)
          .toList()
          .map((e) => e.card)
          .toList(),
    );
    ref.read(handProvider(3).notifier).state = HandEntity(
      handSize: 12,
      cards: state
          .where((element) => element.position == 3)
          .toList()
          .map((e) => e.card)
          .toList(),
    );
    ref.read(handProvider(4).notifier).state = HandEntity(
      handSize: 12,
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
