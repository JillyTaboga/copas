import 'package:copas/domain/entities/game_phases.dart';
import 'package:copas/interface/controllers/deck_controller.dart';
import 'package:copas/interface/controllers/game_controller.dart';
import 'package:copas/interface/game_screen.dart';
import 'package:copas/interface/widgets/card_back.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
