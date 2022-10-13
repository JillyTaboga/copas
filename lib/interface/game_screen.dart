import 'package:copas/domain/entities/game_phases.dart';
import 'package:copas/interface/controllers/game_controller.dart';
import 'package:copas/interface/widgets/card_widget.dart';
import 'package:copas/interface/widgets/distributing_widget.dart';
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
    final turnPhase = ref.watch(turnPhaseProvider);
    final screenSize = ref.watch(screenSizeProvider);
    final directionPhase = ref.watch(passTypeProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: (matchPhase == MatchPhase.start ||
              matchPhase == MatchPhase.distributing)
          ? const DistributingWidget()
          : Stack(
              children: [
                HandsCenter(screenSize: screenSize),
                if (matchPhase == MatchPhase.playing &&
                    turnPhase == TurnPhase.start)
                  PassWidget(directionPhase: directionPhase)
              ],
            ),
    );
  }
}

class PassWidget extends HookConsumerWidget {
  const PassWidget({
    Key? key,
    required this.directionPhase,
  }) : super(key: key);

  final PassType directionPhase;

  @override
  Widget build(BuildContext context, ref) {
    final cardsToPass = ref.watch(cardsToPassProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        MessageDialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Selecione 3 cartas para passar para um adversário',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 3,
              ),
              Icon(
                directionPhase == PassType.front
                    ? Icons.arrow_drop_up
                    : directionPhase == PassType.right
                        ? Icons.arrow_right
                        : Icons.arrow_left,
                size: 50,
                color: Colors.green,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: cardsToPass
              .map((e) => CardWidget(
                    card: e,
                    isHover: false,
                    onCardTap: (card) {
                      ref.read(cardsToPassProvider.notifier).removeCard(e);
                    },
                  ))
              .toList(),
        ),
        if (cardsToPass.length == 3) ...[
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(cardsToPassProvider.notifier).pass();
            },
            child: const Text('Confirmar'),
          ),
        ],
        Container(
          constraints: BoxConstraints(
              minHeight: ref.watch(cardSizeProvider).height + 20),
        ),
      ],
    );
  }
}

class MessageDialog extends StatelessWidget {
  const MessageDialog({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          boxShadow: kElevationToShadow[3],
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: child,
      ),
    );
  }
}

class HandsCenter extends StatelessWidget {
  const HandsCenter({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}
