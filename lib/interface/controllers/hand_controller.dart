import 'package:copas/domain/entities/card_entity.dart';
import 'package:copas/domain/entities/hand_entity.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final handProvider = StateProvider.family<HandEntity, int>((ref, player) {
  return const HandEntity(
    cards: [],
  );
});

final selectedCardProvider = StateProvider<CardEntity?>((ref) {
  return;
});
