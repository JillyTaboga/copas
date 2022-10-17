import 'package:copas/interface/controllers/card_to_passs_controller.dart';
import 'package:copas/interface/controllers/game_controller.dart';
import 'package:copas/interface/game_screen.dart';
import 'package:copas/interface/widgets/card_widget.dart';
import 'package:copas/interface/widgets/message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
