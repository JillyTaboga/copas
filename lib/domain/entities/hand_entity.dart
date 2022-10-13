import 'package:copas/domain/entities/card_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hand_entity.freezed.dart';

@freezed
class HandEntity with _$HandEntity {
  const HandEntity._();
  const factory HandEntity({
    @Default([]) List<CardEntity> cards,
  }) = _HandEntity;

  int get handSize => cards.length;
}
