import 'dart:developer';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:hospitals/models/collection.dart';
import 'package:hospitals/models/collectionPhoto.dart';
part 'serializers.g.dart';

/// Collection of generated serializers for the built_value chat example.
@SerializersFor([
  User,
  CoverPhoto,
  Links,
  ProfileImage,
  Urls,
  Collection,
  CollectionPhoto,
  PhotoLinks
])
final Serializers serializers = _$serializers;

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

T deserialize<T>(dynamic value) {
  return standardSerializers.deserializeWith<T>(
      standardSerializers.serializerForType(T) as Serializer<T>, value);
}

BuiltList<T> deserializeListOf<T>(dynamic value) => BuiltList.from(
    value.map((value) => deserialize<T>(value)).toList(growable: false));
