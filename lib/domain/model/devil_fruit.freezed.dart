// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'devil_fruit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DevilFruit {
  int get id => throw _privateConstructorUsedError;
  String get romanName => throw _privateConstructorUsedError;
  String get filename => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  LatLng get position => throw _privateConstructorUsedError;

  /// Create a copy of DevilFruit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DevilFruitCopyWith<DevilFruit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DevilFruitCopyWith<$Res> {
  factory $DevilFruitCopyWith(
          DevilFruit value, $Res Function(DevilFruit) then) =
      _$DevilFruitCopyWithImpl<$Res, DevilFruit>;
  @useResult
  $Res call(
      {int id,
      String romanName,
      String filename,
      String name,
      String type,
      String description,
      LatLng position});
}

/// @nodoc
class _$DevilFruitCopyWithImpl<$Res, $Val extends DevilFruit>
    implements $DevilFruitCopyWith<$Res> {
  _$DevilFruitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DevilFruit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? romanName = null,
    Object? filename = null,
    Object? name = null,
    Object? type = null,
    Object? description = null,
    Object? position = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      romanName: null == romanName
          ? _value.romanName
          : romanName // ignore: cast_nullable_to_non_nullable
              as String,
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as LatLng,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DevilFruitImplCopyWith<$Res>
    implements $DevilFruitCopyWith<$Res> {
  factory _$$DevilFruitImplCopyWith(
          _$DevilFruitImpl value, $Res Function(_$DevilFruitImpl) then) =
      __$$DevilFruitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String romanName,
      String filename,
      String name,
      String type,
      String description,
      LatLng position});
}

/// @nodoc
class __$$DevilFruitImplCopyWithImpl<$Res>
    extends _$DevilFruitCopyWithImpl<$Res, _$DevilFruitImpl>
    implements _$$DevilFruitImplCopyWith<$Res> {
  __$$DevilFruitImplCopyWithImpl(
      _$DevilFruitImpl _value, $Res Function(_$DevilFruitImpl) _then)
      : super(_value, _then);

  /// Create a copy of DevilFruit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? romanName = null,
    Object? filename = null,
    Object? name = null,
    Object? type = null,
    Object? description = null,
    Object? position = null,
  }) {
    return _then(_$DevilFruitImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      romanName: null == romanName
          ? _value.romanName
          : romanName // ignore: cast_nullable_to_non_nullable
              as String,
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as LatLng,
    ));
  }
}

/// @nodoc

class _$DevilFruitImpl implements _DevilFruit {
  const _$DevilFruitImpl(
      {required this.id,
      required this.romanName,
      required this.filename,
      required this.name,
      required this.type,
      required this.description,
      required this.position});

  @override
  final int id;
  @override
  final String romanName;
  @override
  final String filename;
  @override
  final String name;
  @override
  final String type;
  @override
  final String description;
  @override
  final LatLng position;

  @override
  String toString() {
    return 'DevilFruit(id: $id, romanName: $romanName, filename: $filename, name: $name, type: $type, description: $description, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DevilFruitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.romanName, romanName) ||
                other.romanName == romanName) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, romanName, filename, name, type, description, position);

  /// Create a copy of DevilFruit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DevilFruitImplCopyWith<_$DevilFruitImpl> get copyWith =>
      __$$DevilFruitImplCopyWithImpl<_$DevilFruitImpl>(this, _$identity);
}

abstract class _DevilFruit implements DevilFruit {
  const factory _DevilFruit(
      {required final int id,
      required final String romanName,
      required final String filename,
      required final String name,
      required final String type,
      required final String description,
      required final LatLng position}) = _$DevilFruitImpl;

  @override
  int get id;
  @override
  String get romanName;
  @override
  String get filename;
  @override
  String get name;
  @override
  String get type;
  @override
  String get description;
  @override
  LatLng get position;

  /// Create a copy of DevilFruit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DevilFruitImplCopyWith<_$DevilFruitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
