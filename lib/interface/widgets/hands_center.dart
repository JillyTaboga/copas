import 'package:copas/interface/widgets/hand_widget.dart';
import 'package:flutter/material.dart';

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
