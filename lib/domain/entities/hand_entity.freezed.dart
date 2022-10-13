// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'hand_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HandEntity {
  int get handSize => throw _privateConstructorUsedError;
  List<CardEntity> get cards => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HandEntityCopyWith<HandEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HandEntityCopyWith<$Res> {
  factory $HandEntityCopyWith(
          HandEntity value, $Res Function(HandEntity) then) =
      _$HandEntityCopyWithImpl<$Res>;
  $Res call({int handSize, List<CardEntity> cards});
}

/// @nodoc
class _$HandEntityCopyWithImpl<$Res> implements $HandEntityCopyWith<$Res> {
  _$HandEntityCopyWithImpl(this._value, this._then);

  final HandEntity _value;
  // ignore: unused_field
  final $Res Function(HandEntity) _then;

  @override
  $Res call({
    Object? handSize = freezed,
    Object? cards = freezed,
  }) {
    return _then(_value.copyWith(
      handSize: handSize == freezed
          ? _value.handSize
          : handSize // ignore: cast_nullable_to_non_nullable
              as int,
      cards: cards == freezed
          ? _value.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<CardEntity>,
    ));
  }
}

/// @nodoc
abstract class _$$_HandEntityCopyWith<$Res>
    implements $HandEntityCopyWith<$Res> {
  factory _$$_HandEntityCopyWith(
          _$_HandEntity value, $Res Function(_$_HandEntity) then) =
      __$$_HandEntityCopyWithImpl<$Res>;
  @override
  $Res call({int handSize, List<CardEntity> cards});
}

/// @nodoc
class __$$_HandEntityCopyWithImpl<$Res> extends _$HandEntityCopyWithImpl<$Res>
    implements _$$_HandEntityCopyWith<$Res> {
  __$$_HandEntityCopyWithImpl(
      _$_HandEntity _value, $Res Function(_$_HandEntity) _then)
      : super(_value, (v) => _then(v as _$_HandEntity));

  @override
  _$_HandEntity get _value => super._value as _$_HandEntity;

  @override
  $Res call({
    Object? handSize = freezed,
    Object? cards = freezed,
  }) {
    return _then(_$_HandEntity(
      handSize: handSize == freezed
          ? _value.handSize
          : handSize // ignore: cast_nullable_to_non_nullable
              as int,
      cards: cards == freezed
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<CardEntity>,
    ));
  }
}

/// @nodoc

class _$_HandEntity implements _HandEntity {
  const _$_HandEntity(
      {required this.handSize, final List<CardEntity> cards = const []})
      : _cards = cards;

  @override
  final int handSize;
  final List<CardEntity> _cards;
  @override
  @JsonKey()
  List<CardEntity> get cards {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  String toString() {
    return 'HandEntity(handSize: $handSize, cards: $cards)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HandEntity &&
            const DeepCollectionEquality().equals(other.handSize, handSize) &&
            const DeepCollectionEquality().equals(other._cards, _cards));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(handSize),
      const DeepCollectionEquality().hash(_cards));

  @JsonKey(ignore: true)
  @override
  _$$_HandEntityCopyWith<_$_HandEntity> get copyWith =>
      __$$_HandEntityCopyWithImpl<_$_HandEntity>(this, _$identity);
}

abstract class _HandEntity implements HandEntity {
  const factory _HandEntity(
      {required final int handSize,
      final List<CardEntity> cards}) = _$_HandEntity;

  @override
  int get handSize;
  @override
  List<CardEntity> get cards;
  @override
  @JsonKey(ignore: true)
  _$$_HandEntityCopyWith<_$_HandEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
