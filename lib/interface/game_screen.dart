import 'package:copas/domain/entities/game_phases.dart';
import 'package:copas/domain/use_cases/choose_card_to_pass.dart';
import 'package:copas/interface/controllers/game_controller.dart';
import 'package:copas/interface/controllers/turn_controller.dart';
import 'package:copas/interface/widgets/card_widget.dart';
import 'package:copas/interface/widgets/distributing_widget.dart';
import 'package:copas/interface/widgets/hands_center.dart';
import 'package:copas/interface/widgets/message_dialog.dart';
import 'package:copas/interface/widgets/pass_widget.dart';
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
    ref.listen(turnProvider, (oldState, newState) {
      if (newState != oldState && newState != 1) {
        CpuAi.playACard(ref);
      }
    });
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
    final turnPhase = ref.watch(turnPhaseProvider);
    final screenSize = ref.watch(screenSizeProvider);
    final directionPhase = ref.watch(passTypeProvider);
    final cardSize = ref.watch(cardSizeProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: (matchPhase == MatchPhase.start ||
              matchPhase == MatchPhase.distributing)
          ? const DistributingWidget()
          : Stack(
              children: [
                HandsCenter(screenSize: screenSize),
                if (matchPhase == MatchPhase.playing) const TableCardsWidget(),
                if (matchPhase == MatchPhase.playing &&
                    turnPhase == TurnPhase.playing) ...[
                  Positioned(
                    bottom: cardSize.height + 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: MessageDialog(
                        child: Text(
                            'Turno do ${ref.watch(currentPlayerNameProvider)}'),
                      ),
                    ),
                  )
                ],
                if (matchPhase == MatchPhase.passing &&
                    turnPhase == TurnPhase.start)
                  PassWidget(directionPhase: directionPhase)
              ],
            ),
    );
  }
}

class TableCardsWidget extends HookConsumerWidget {
  const TableCardsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final cardSize = ref.watch(cardSizeProvider);
    final tableCards = ref.watch(cardsInTableProvider);
    return Center(
      child: SizedBox(
        width: cardSize.height,
        height: cardSize.height,
        child: ProviderScope(
          overrides: [
            cardSizeProvider.overrideWithValue(
              Size(cardSize.width * 0.75, cardSize.height * 0.75),
            ),
          ],
          child: Stack(
            children: [
              ...tableCards.map(
                (e) {
                  final index = tableCards.indexOf(e);
                  return AnimatedSlide(
                    duration: const Duration(milliseconds: 200),
                    offset: Offset(
                      index * 0.25,
                      index * 0.05,
                    ),
                    child: AnimatedRotation(
                      duration: const Duration(milliseconds: 100),
                      turns: index * 0.03,
                      child: CardWidget(
                        card: e.card,
                        isHover: false,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
