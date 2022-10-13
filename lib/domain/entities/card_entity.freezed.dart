// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'card_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CardEntity {
  Symbol get symbol => throw _privateConstructorUsedError;
  CardValue get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CardEntityCopyWith<CardEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardEntityCopyWith<$Res> {
  factory $CardEntityCopyWith(
          CardEntity value, $Res Function(CardEntity) then) =
      _$CardEntityCopyWithImpl<$Res>;
  $Res call({Symbol symbol, CardValue value});
}

/// @nodoc
class _$CardEntityCopyWithImpl<$Res> implements $CardEntityCopyWith<$Res> {
  _$CardEntityCopyWithImpl(this._value, this._then);

  final CardEntity _value;
  // ignore: unused_field
  final $Res Function(CardEntity) _then;

  @override
  $Res call({
    Object? symbol = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      symbol: symbol == freezed
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as Symbol,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as CardValue,
    ));
  }
}

/// @nodoc
abstract class _$$_CardEntityCopyWith<$Res>
    implements $CardEntityCopyWith<$Res> {
  factory _$$_CardEntityCopyWith(
          _$_CardEntity value, $Res Function(_$_CardEntity) then) =
      __$$_CardEntityCopyWithImpl<$Res>;
  @override
  $Res call({Symbol symbol, CardValue value});
}

/// @nodoc
class __$$_CardEntityCopyWithImpl<$Res> extends _$CardEntityCopyWithImpl<$Res>
    implements _$$_CardEntityCopyWith<$Res> {
  __$$_CardEntityCopyWithImpl(
      _$_CardEntity _value, $Res Function(_$_CardEntity) _then)
      : super(_value, (v) => _then(v as _$_CardEntity));

  @override
  _$_CardEntity get _value => super._value as _$_CardEntity;

  @override
  $Res call({
    Object? symbol = freezed,
    Object? value = freezed,
  }) {
    return _then(_$_CardEntity(
      symbol == freezed
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as Symbol,
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as CardValue,
    ));
  }
}

/// @nodoc

class _$_CardEntity extends _CardEntity {
  const _$_CardEntity(this.symbol, this.value) : super._();

  @override
  final Symbol symbol;
  @override
  final CardValue value;

  @override
  String toString() {
    return 'CardEntity(symbol: $symbol, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CardEntity &&
            const DeepCollectionEquality().equals(other.symbol, symbol) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(symbol),
      const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  _$$_CardEntityCopyWith<_$_CardEntity> get copyWith =>
      __$$_CardEntityCopyWithImpl<_$_CardEntity>(this, _$identity);
}

abstract class _CardEntity extends CardEntity {
  const factory _CardEntity(final Symbol symbol, final CardValue value) =
      _$_CardEntity;
  const _CardEntity._() : super._();

  @override
  Symbol get symbol;
  @override
  CardValue get value;
  @override
  @JsonKey(ignore: true)
  _$$_CardEntityCopyWith<_$_CardEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
