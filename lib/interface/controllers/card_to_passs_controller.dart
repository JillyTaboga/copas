import 'package:copas/domain/entities/card_entity.dart';
import 'package:copas/domain/entities/game_phases.dart';
import 'package:copas/domain/entities/hand_entity.dart';
import 'package:copas/domain/use_cases/choose_card_to_pass.dart';
import 'package:copas/interface/controllers/game_controller.dart';
import 'package:copas/interface/controllers/hand_controller.dart';
import 'package:copas/interface/controllers/turn_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cardsToPassProvider =
    StateNotifierProvider<CardsToPassNotifier, List<CardEntity>>((ref) {
  return CardsToPassNotifier(
    ref,
    ref.watch(passTypeProvider),
  );
});

class CardsToPassNotifier extends StateNotifier<List<CardEntity>> {
  CardsToPassNotifier(
    this.ref,
    this.passType,
  ) : super([]);

  final Ref ref;
  final PassType passType;

  addCard(CardEntity card) {
    final playerCards = ref.read(handProvider(1));
    var newState = [...state, card];
    var newCards = [...playerCards.cards];
    if (state.length >= 3) {
      final cardToRemove = state.first;
      newState.remove(cardToRemove);
      newCards.add(cardToRemove);
    }
    state = newState;
    newCards.removeWhere((element) => element == card);
    ref.read(handProvider(1).notifier).state =
        playerCards.copyWith(cards: newCards);
  }

  removeCard(CardEntity card) {
    if (state.contains(card)) {
      var newState = [...state];
      newState.remove(card);
      final playerCards = ref.read(handProvider(1));
      var newCards = [...playerCards.cards, card];
      ref.read(handProvider(1).notifier).state =
          playerCards.copyWith(cards: newCards);
      state = newState;
    }
  }

  _finishPass(
    HandEntity hand1,
    HandEntity hand2,
    HandEntity hand3,
    HandEntity hand4,
  ) {
    ref.read(handProvider(1).notifier).state = hand1;
    ref.read(handProvider(2).notifier).state = hand2;
    ref.read(handProvider(3).notifier).state = hand3;
    ref.read(handProvider(4).notifier).state = hand4;
    ref.read(matchProvider.notifier).state = MatchPhase.playing;
    ref.read(turnPhaseProvider.notifier).state = TurnPhase.playing;
    ref.read(turnProvider.notifier).setStartPlayer();
    _advance();
    if (mounted) state = [];
  }

  _advance() {
    switch (passType) {
      case PassType.right:
        ref.read(passTypeProvider.notifier).state = PassType.left;
        break;
      case PassType.left:
        ref.read(passTypeProvider.notifier).state = PassType.front;
        break;
      case PassType.front:
        ref.read(passTypeProvider.notifier).state = PassType.none;
        break;
      case PassType.none:
        ref.read(passTypeProvider.notifier).state = PassType.right;
        break;
    }
  }

  pass() {
    final playerHand = ref.read(handProvider(1));
    final cpu1 = ref.read(handProvider(2));
    final cpu2 = ref.read(handProvider(3));
    final cpu3 = ref.read(handProvider(4));
    var cpu1Cards = [...cpu1.cards];
    var cpu2Cards = [...cpu2.cards];
    var cpu3Cards = [...cpu3.cards];
    final cpu1CardsToPass = CpuAi.chooseCardToPass(cpu1);
    final cpu2CardsToPass = CpuAi.chooseCardToPass(cpu2);
    final cpu3CardsToPass = CpuAi.chooseCardToPass(cpu3);
    cpu1Cards.removeWhere((element) => cpu1CardsToPass.contains(element));
    cpu2Cards.removeWhere((element) => cpu2CardsToPass.contains(element));
    cpu3Cards.removeWhere((element) => cpu3CardsToPass.contains(element));
    if (passType == PassType.right) {
      final newPlayerHand = playerHand.copyWith(
        cards: [
          ...playerHand.cards,
          ...cpu3CardsToPass,
        ],
      );
      final cpu1NewHand = cpu1.copyWith(
        cards: [
          ...cpu1Cards,
          ...state,
        ],
      );
      final cpu2NewHand = cpu2.copyWith(
        cards: [
          ...cpu2Cards,
          ...cpu1CardsToPass,
        ],
      );
      final cpu3NewHand = cpu3.copyWith(
        cards: [
          ...cpu3Cards,
          ...cpu2CardsToPass,
        ],
      );
      _finishPass(newPlayerHand, cpu1NewHand, cpu2NewHand, cpu3NewHand);
    }
    if (passType == PassType.front) {
      final newPlayerHand = playerHand.copyWith(
        cards: [
          ...playerHand.cards,
          ...cpu2CardsToPass,
        ],
      );
      final cpu1NewHand = cpu1.copyWith(
        cards: [
          ...cpu1Cards,
          ...cpu3CardsToPass,
        ],
      );
      final cpu2NewHand = cpu2.copyWith(
        cards: [
          ...cpu2Cards,
          ...state,
        ],
      );
      final cpu3NewHand = cpu3.copyWith(
        cards: [
          ...cpu3Cards,
          ...cpu1CardsToPass,
        ],
      );
      _finishPass(newPlayerHand, cpu1NewHand, cpu2NewHand, cpu3NewHand);
    }
    if (passType == PassType.left) {
      final newPlayerHand = playerHand.copyWith(
        cards: [
          ...playerHand.cards,
          ...cpu1CardsToPass,
        ],
      );
      final cpu1NewHand = cpu1.copyWith(
        cards: [
          ...cpu1Cards,
          ...cpu2CardsToPass,
        ],
      );
      final cpu2NewHand = cpu2.copyWith(
        cards: [
          ...cpu2Cards,
          ...cpu3CardsToPass,
        ],
      );
      final cpu3NewHand = cpu3.copyWith(
        cards: [
          ...cpu3Cards,
          ...state,
        ],
      );
      _finishPass(newPlayerHand, cpu1NewHand, cpu2NewHand, cpu3NewHand);
    }
  }
}
