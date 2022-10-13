import 'package:copas/domain/entities/game_phases.dart';
import 'package:copas/interface/controllers/deck_controller.dart';
import 'package:copas/interface/controllers/game_controller.dart';
import 'package:copas/interface/controllers/hand_controller.dart';
import 'package:copas/interface/widgets/card_back.dart';
import 'package:copas/interface/widgets/hand_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final screenSizeProvider = StateProvider<Size>((ref) {
  return Size.zero;
});

final cardSizeProvider = Provider<Size>(
  (ref) {
    final screenSize = ref.watch(screenSizeProvider);
    if (screenSize == Size.zero) return screenSize;
    final maxHeightByHeight = (screenSize.height / 3) - 40;
    final maxHeightByWidth =
        ((screenSize.width / 2)) - ((((screenSize.width / 2)) * 0.6) / 2);
    final realHeight = maxHeightByWidth > maxHeightByHeight
        ? maxHeightByHeight
        : maxHeightByWidth;
    final realWidht = realHeight * 0.6;
    return Size(realWidht, realHeight);
  },
);

class GameScreen extends HookConsumerWidget {
  const GameScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.green.shade800,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          final currentSize = ref.watch(screenSizeProvider);
          if (size != currentSize) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              ref.read(screenSizeProvider.notifier).state = size;
            });
          }
          return const GameCenter();
        },
      ),
    );
  }
}

class GameCenter extends HookConsumerWidget {
  const GameCenter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final matchPhase = ref.watch(matchProvider);
    final screenSize = ref.watch(screenSizeProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: (matchPhase == MatchPhase.start ||
              matchPhase == MatchPhase.distributing)
          ? const DistributingWidget()
          : Stack(
              fit: StackFit.expand,
              children: [
                const Center(
                  child: PlayerHandWidget(
                    playerId: 1,
                  ),
                ),
                Center(
                  child: AnimatedSlide(
                    duration: const Duration(milliseconds: 200),
                    offset: const Offset(-0.2, 0),
                    child: AnimatedRotation(
                      turns: 0.25,
                      duration: const Duration(milliseconds: 300),
                      child: SizedBox(
                        height: screenSize.width,
                        child: const PlayerHandWidget(
                          playerId: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const AnimatedRotation(
                  turns: 0.50,
                  duration: Duration(milliseconds: 300),
                  child: PlayerHandWidget(
                    playerId: 3,
                  ),
                ),
                Center(
                  child: AnimatedSlide(
                    duration: const Duration(milliseconds: 200),
                    offset: const Offset(0.2, 0),
                    child: AnimatedRotation(
                      turns: 0.75,
                      duration: const Duration(milliseconds: 300),
                      child: SizedBox(
                        height: screenSize.width,
                        child: const PlayerHandWidget(
                          playerId: 4,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class DistributingWidget extends HookConsumerWidget {
  const DistributingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final cardSize = ref.watch(cardSizeProvider);
    final screenSize = ref.watch(screenSizeProvider);
    final matchPhase = ref.watch(matchProvider);
    return Stack(
      children: [
        ...ref
            .watch(deckProvider)
            .map(
              (e) => AnimatedAlign(
                duration: const Duration(milliseconds: 100),
                alignment: e.position == 0
                    ? Alignment.center
                    : e.position == 1
                        ? Alignment.bottomCenter
                        : e.position == 2
                            ? Alignment.centerRight
                            : e.position == 3
                                ? Alignment.topCenter
                                : Alignment.centerLeft,
                child: AnimatedRotation(
                  duration: const Duration(milliseconds: 100),
                  turns: (e.position == 0 || e.position == 1)
                      ? 0
                      : e.position == 2
                          ? 0.25
                          : e.position == 3
                              ? 0.5
                              : 0.75,
                  child: CardBackWidget(
                    cardSize: ref.watch(cardSizeProvider),
                  ),
                ),
              ),
            )
            .toList(),
        if (matchPhase == MatchPhase.start)
          Positioned(
            top: (screenSize.height / 2) + (cardSize.height / 2) + 10,
            child: SizedBox(
              width: screenSize.width,
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(matchProvider.notifier).deal();
                  },
                  child: const Text('Dar as cartas'),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

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
    return HandWidget(
      hand: hand,
      isPlayer: playerId == 1,
      onCardClick: playerId == 1
          ? (card) {
              var newCards = [...hand.cards];
              newCards.remove(card);
              handNotifier.state = hand.copyWith(cards: newCards);
            }
          : null,
    );
  }
}
