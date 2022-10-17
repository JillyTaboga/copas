import 'package:copas/domain/entities/game_phases.dart';
import 'package:copas/interface/controllers/deck_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final gamePhaseProvider = StateProvider<GamePhase>((ref) {
  return GamePhase.playing;
});

class MatchPhaseNotifier extends StateNotifier<MatchPhase> {
  MatchPhaseNotifier(this.ref) : super(MatchPhase.start);

  final Ref ref;

  deal() async {
    state = MatchPhase.distributing;
    await ref.read(deckProvider.notifier).distrubute();
    if (ref.read(passTypeProvider) == PassType.none) {
      state = MatchPhase.playing;
    } else {
      state = MatchPhase.passing;
    }
  }
}

final matchProvider =
    StateNotifierProvider<MatchPhaseNotifier, MatchPhase>((ref) {
  return MatchPhaseNotifier(ref);
});

class TurnPhaseNotifier extends StateNotifier<TurnPhase> {
  TurnPhaseNotifier() : super(TurnPhase.start);
}

final turnPhaseProvider =
    StateNotifierProvider<TurnPhaseNotifier, TurnPhase>((ref) {
  return TurnPhaseNotifier();
});

final passTypeProvider = StateProvider<PassType>((ref) {
  return PassType.right;
});

enum PassType {
  right,
  left,
  front,
  none,
}

final heartsBrokenProvider = StateProvider<bool>((ref) {
  return false;
});
