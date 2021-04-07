library collection_photo;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hospitals/models/collection.dart';
import 'package:hospitals/models/serializers.dart';

part 'collectionPhoto.g.dart';

abstract class CollectionPhoto
    implements Built<CollectionPhoto, CollectionPhotoBuilder> {
  CollectionPhoto._();

  factory CollectionPhoto([updates(CollectionPhotoBuilder b)]) =
      _$CollectionPhoto;

  @BuiltValueField(wireName: 'id')
  String get id;
  @BuiltValueField(wireName: 'created_at')
  String get createdAt;
  @BuiltValueField(wireName: 'updated_at')
  String get updatedAt;
  @nullable
  @BuiltValueField(wireName: 'promoted_at')
  String get promotedAt;
  @BuiltValueField(wireName: 'width')
  int get width;
  @BuiltValueField(wireName: 'height')
  int get height;
  @BuiltValueField(wireName: 'color')
  String get color;
  @nullable
  @BuiltValueField(wireName: 'description')
  String get description;
  @nullable
  @BuiltValueField(wireName: 'alt_description')
  String get altDescription;
  @BuiltValueField(wireName: 'urls')
  Urls get urls;
  @BuiltValueField(wireName: 'links')
  PhotoLinks get links;
  @nullable
  @BuiltValueField(wireName: 'categories')
  BuiltList<String> get categories;
  @BuiltValueField(wireName: 'likes')
  int get likes;
  @BuiltValueField(wireName: 'liked_by_user')
  bool get likedByUser;
  @nullable
  @BuiltValueField(wireName: 'current_user_collections')
  BuiltList<int> get currentUserCollections;
  @BuiltValueField(wireName: 'user')
  User get user;
  String toJson() {
    return json
        .encode(serializers.serializeWith(CollectionPhoto.serializer, this));
  }

  static CollectionPhoto fromJson(String jsonString) {
    return serializers.deserializeWith(
        CollectionPhoto.serializer, json.decode(jsonString));
  }

  static Serializer<CollectionPhoto> get serializer =>
      _$collectionPhotoSerializer;
}


abstract class PhotoLinks implements Built<PhotoLinks, PhotoLinksBuilder> {
  PhotoLinks._();

  factory PhotoLinks([updates(PhotoLinksBuilder b)]) = _$PhotoLinks;

  @BuiltValueField(wireName: 'self')
  String get self;
  @BuiltValueField(wireName: 'html')
  String get html;
  @BuiltValueField(wireName: 'download')
  String get download;
  @BuiltValueField(wireName: 'download_location')
  String get downloadLocation;
  String toJson() {
    return json.encode(serializers.serializeWith(PhotoLinks.serializer, this));
  }

  static PhotoLinks fromJson(String jsonString) {
    return serializers.deserializeWith(
        PhotoLinks.serializer, json.decode(jsonString));
  }

  static Serializer<PhotoLinks> get serializer => _$photoLinksSerializer;
}