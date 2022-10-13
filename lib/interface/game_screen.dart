import 'package:copas/data/cards_data.dart';
import 'package:copas/domain/entities/card_values.dart';
import 'package:copas/domain/entities/simbols.dart';
import 'package:copas/interface/painters/copas_painters.dart';
import 'package:copas/interface/widgets/card_shadows.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameScreen extends HookConsumerWidget {
  const GameScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Wrap(
          children: deck.map((e) {
            return SizedBox(
              width: constraints.maxWidth / 10,
              height: constraints.maxWidth / 10 * 1.5,
              child: CardWidget(
                symbol: e.symbol,
                value: e.value,
              ),
            );
          }).toList(),
        );
      }),
    );
  }
}

final _cardHoverProvider = StateProvider<bool>((ref) {
  return false;
});

class CardWidget extends HookConsumerWidget {
  const CardWidget({
    Key? key,
    required this.symbol,
    required this.value,
  }) : super(key: key);

  final CardValue value;
  final Symbol symbol;

  @override
  Widget build(BuildContext context, ref) {
    return LayoutBuilder(builder: (context, constraints) {
      final widht = constraints.maxWidth;
      final height = widht * 1.5;
      final isHover = ref.watch(_cardHoverProvider);
      return MouseRegion(
        onEnter: (event) {
          if (!isHover) {
            ref.read(_cardHoverProvider.notifier).state = true;
          }
        },
        onExit: (event) {
          if (isHover) {
            ref.read(_cardHoverProvider.notifier).state = false;
          }
        },
        child: Container(
          height: height,
          width: widht,
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsets.all(widht / 20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              CardShadow(
                onHover: isHover,
                symbol: symbol,
                size: widht,
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: widht / 25),
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black54, width: 0.2),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    value.label,
                    style: TextStyle(
                      fontSize: widht / 5,
                      fontWeight: FontWeight.bold,
                      color: symbol.color,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SizedBox.square(
                      dimension: widht / 3,
                      child: CustomPaint(
                        painter: CopasPainter(),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Transform.scale(
                    scale: -1,
                    child: Text(
                      value.label,
                      style: TextStyle(
                        fontSize: widht / 5,
                        fontWeight: FontWeight.bold,
                        color: symbol.color,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
