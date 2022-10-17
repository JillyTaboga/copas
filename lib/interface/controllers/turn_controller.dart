import 'package:copas/domain/entities/card_entity.dart';
import 'package:copas/domain/entities/card_values.dart';
import 'package:copas/domain/entities/game_phases.dart';
import 'package:copas/domain/entities/simbols.dart';
import 'package:copas/interface/controllers/game_controller.dart';
import 'package:copas/interface/controllers/hand_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final lastPlayerProvider = Provider<int>((ref) {
  final startPlayer = ref.watch(starterPlayerProvider);
  switch (startPlayer) {
    case 1:
      return 4;
    case 2:
      return 1;
    case 3:
      return 2;
    case 4:
      return 3;
    default:
      return 1;
  }
});

final starterPlayerProvider = StateProvider<int>((ref) {
  return 1;
});

final currentPlayerNameProvider = Provider<String>((ref) {
  final currentPlayer = ref.watch(turnProvider);
  switch (currentPlayer) {
    case 1:
      return 'Jogador';
    case 2:
      return 'Adversário Direita';
    case 3:
      return 'Adversário Frente';
    case 4:
      return 'Adversário Esquerda';
    default:
      return '';
  }
});

final turnProvider = StateNotifierProvider<TurnNotifier, int>((ref) {
  return TurnNotifier(ref);
});

class TurnNotifier extends StateNotifier<int> {
  TurnNotifier(this.ref) : super(1);

  final Ref ref;

  _start(int player) {
    ref.read(starterPlayerProvider.notifier).state = player;
    state = player;
  }

  setStartPlayer() {
    final player = ref.read(handProvider(1));
    if (player.hasStart()) {
      _start(1);
      return;
    }
    final cpu1 = ref.read(handProvider(2));
    if (cpu1.hasStart()) {
      _start(2);
      return;
    }
    final cpu2 = ref.read(handProvider(3));
    if (cpu2.hasStart()) {
      _start(3);
      return;
    }
    final cpu3 = ref.read(handProvider(4));
    if (cpu3.hasStart()) {
      _start(4);
      return;
    }
  }

  advance() {
    if (state == ref.read(lastPlayerProvider)) {
      ref.read(turnPhaseProvider.notifier).state = TurnPhase.review;
    } else {
      int next = state + 1;
      if (next == 5) {
        next = 1;
      }
      state = next;
    }
  }
}

final cardsInTableProvider =
    StateNotifierProvider<CardsInTableNotifier, List<CardInTable>>((ref) {
  return CardsInTableNotifier(ref);
});

class CardsInTableNotifier extends StateNotifier<List<CardInTable>> {
  CardsInTableNotifier(this.ref) : super([]);

  final Ref ref;

  playCard(
    int player,
    CardEntity card,
  ) {
    final hand = ref.read(handProvider(player));
    var cards = [...hand.cards];
    cards.remove(card);
    ref.read(handProvider(player).notifier).state = hand.copyWith(cards: cards);
    ref.read(turnProvider.notifier).advance();
    state = [
      ...state,
      CardInTable(
        card: card,
        playedBy: player,
      ),
    ];
  }
}

final tableSymbolProvider = Provider<Symbol?>((ref) {
  final currentTable = ref.watch(cardsInTableProvider);
  return currentTable.isEmpty ? null : currentTable.first.card.symbol;
});

final possibleCardsProvider = Provider<List<CardEntity>>((ref) {
  final currentTurn = ref.watch(turnProvider);
  if (currentTurn != 1) return [];
  final playerHand = ref.watch(handProvider(1)).cards;
  if (playerHand.any((element) =>
      element.symbol == Symbol.clubs && element.value == CardValue.two)) {
    return playerHand
        .where((element) =>
            element.symbol == Symbol.clubs && element.value == CardValue.two)
        .toList();
  }
  final tableSymbol = ref.watch(tableSymbolProvider);
  final hasSymbol = playerHand.any((element) => element.symbol == tableSymbol);
  print(tableSymbol);
  print(hasSymbol);
  if (tableSymbol == null || !hasSymbol) {
    final heartsBroken = ref.watch(heartsBrokenProvider);
    if (heartsBroken) {
      return playerHand;
    }
    if (!playerHand.any((element) => element.symbol != Symbol.heart)) {
      return playerHand;
    }
    return playerHand
        .where((element) => element.symbol != Symbol.heart)
        .toList();
  } else {
    return playerHand
        .where((element) => element.symbol == tableSymbol)
        .toList();
  }
});

class CardInTable {
  final CardEntity card;
  final int playedBy;
  CardInTable({
    required this.card,
    required this.playedBy,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CardInTable &&
        other.card == card &&
        other.playedBy == playedBy;
  }

  @override
  int get hashCode => card.hashCode ^ playedBy.hashCode;
}
