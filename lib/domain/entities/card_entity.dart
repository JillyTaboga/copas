import 'package:copas/domain/entities/card_values.dart';
import 'package:copas/domain/entities/simbols.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_entity.freezed.dart';

@freezed
class CardEntity with _$CardEntity {
  const CardEntity._();
  const factory CardEntity(
    Symbol symbol,
    CardValue value,
  ) = _CardEntity;

  int get points {
    if (symbol == Symbol.spades && value == CardValue.queen) {
      return 12;
    }
    if (symbol == Symbol.heart) {
      return 1;
    }
    return 0;
  }
}
