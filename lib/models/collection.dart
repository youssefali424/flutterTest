import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hospitals/models/serializers.dart';

part 'collection.g.dart';

abstract class Collection implements Built<Collection, CollectionBuilder> {
  Collection._();

  factory Collection([updates(CollectionBuilder b)]) = _$Collection;

  @BuiltValueField(wireName: 'id')
  String get id;
  @BuiltValueField(wireName: 'title')
  String get title;
  @nullable
  @BuiltValueField(wireName: 'description')
  String get description;
  @nullable
  @BuiltValueField(wireName: 'published_at')
  String get publishedAt;
  @nullable
  @BuiltValueField(wireName: 'updated_at')
  String get updatedAt;
  @BuiltValueField(wireName: 'total_photos')
  int get totalPhotos;
  @BuiltValueField(wireName: 'private')
  bool get private;
  @BuiltValueField(wireName: 'share_key')
  @nullable
  String get shareKey;
  @BuiltValueField(wireName: 'cover_photo')
  CoverPhoto get coverPhoto;
  @BuiltValueField(wireName: 'user')
  User get user;
  @BuiltValueField(wireName: 'links')
  Links get links;
  String toJson() {
    return json.encode(serializers.serializeWith(Collection.serializer, this));
  }

  static Collection fromJson(String jsonString) {
    return serializers.deserializeWith(
        Collection.serializer, json.decode(jsonString));
  }

  static Serializer<Collection> get serializer => _$collectionSerializer;
}

abstract class CoverPhoto implements Built<CoverPhoto, CoverPhotoBuilder> {
  CoverPhoto._();

  factory CoverPhoto([updates(CoverPhotoBuilder b)]) = _$CoverPhoto;

  @BuiltValueField(wireName: 'id')
  String get id;
  @BuiltValueField(wireName: 'width')
  int get width;
  @BuiltValueField(wireName: 'height')
  int get height;
  @BuiltValueField(wireName: 'color')
  String get color;
  @BuiltValueField(wireName: 'likes')
  int get likes;
  @BuiltValueField(wireName: 'liked_by_user')
  bool get likedByUser;
  @nullable
  @BuiltValueField(wireName: 'description')
  String get description;
  @BuiltValueField(wireName: 'user')
  User get user;
  @BuiltValueField(wireName: 'urls')
  Urls get urls;
  @BuiltValueField(wireName: 'links')
  Links get links;
  String toJson() {
    return json.encode(serializers.serializeWith(CoverPhoto.serializer, this));
  }

  static CoverPhoto fromJson(String jsonString) {
    return serializers.deserializeWith(
        CoverPhoto.serializer, json.decode(jsonString));
  }

  static Serializer<CoverPhoto> get serializer => _$coverPhotoSerializer;
}

abstract class User implements Built<User, UserBuilder> {
  User._();

  factory User([updates(UserBuilder b)]) = _$User;

  @BuiltValueField(wireName: 'id')
  String get id;
  @BuiltValueField(wireName: 'updated_at')
  String get updatedAt;
  @BuiltValueField(wireName: 'username')
  String get username;
  @BuiltValueField(wireName: 'name')
  String get name;
  @nullable
  @BuiltValueField(wireName: 'portfolio_url')
  String get portfolioUrl;
  @nullable
  @BuiltValueField(wireName: 'bio')
  String get bio;
  @nullable
  @BuiltValueField(wireName: 'location')
  String get location;
  @BuiltValueField(wireName: 'total_likes')
  int get totalLikes;
  @BuiltValueField(wireName: 'total_photos')
  int get totalPhotos;
  @BuiltValueField(wireName: 'total_collections')
  int get totalCollections;
  @BuiltValueField(wireName: 'profile_image')
  ProfileImage get profileImage;
  @nullable
  @BuiltValueField(wireName: 'links')
  Links get links;
  String toJson() {
    return json.encode(serializers.serializeWith(User.serializer, this));
  }

  static User fromJson(String jsonString) {
    return serializers.deserializeWith(
        User.serializer, json.decode(jsonString));
  }

  static Serializer<User> get serializer => _$userSerializer;
}

abstract class Links implements Built<Links, LinksBuilder> {
  Links._();

  factory Links([updates(LinksBuilder b)]) = _$Links;
  @nullable
  @BuiltValueField(wireName: 'self')
  String get self;
  @nullable
  @BuiltValueField(wireName: 'html')
  String get html;
  @nullable
  @BuiltValueField(wireName: 'photos')
  String get photos;
  @nullable
  @BuiltValueField(wireName: 'related')
  String get related;
  String toJson() {
    return json.encode(serializers.serializeWith(Links.serializer, this));
  }

  static Links fromJson(String jsonString) {
    return serializers.deserializeWith(
        Links.serializer, json.decode(jsonString));
  }

  static Serializer<Links> get serializer => _$linksSerializer;
}

abstract class Urls implements Built<Urls, UrlsBuilder> {
  Urls._();

  factory Urls([updates(UrlsBuilder b)]) = _$Urls;

  @BuiltValueField(wireName: 'raw')
  String get raw;
  @BuiltValueField(wireName: 'full')
  String get full;
  @BuiltValueField(wireName: 'regular')
  String get regular;
  @BuiltValueField(wireName: 'small')
  String get small;
  @BuiltValueField(wireName: 'thumb')
  String get thumb;
  String toJson() {
    return json.encode(serializers.serializeWith(Urls.serializer, this));
  }

  static Urls fromJson(String jsonString) {
    return serializers.deserializeWith(
        Urls.serializer, json.decode(jsonString));
  }

  static Serializer<Urls> get serializer => _$urlsSerializer;
}

abstract class ProfileImage
    implements Built<ProfileImage, ProfileImageBuilder> {
  ProfileImage._();

  factory ProfileImage([updates(ProfileImageBuilder b)]) = _$ProfileImage;

  @BuiltValueField(wireName: 'small')
  String get small;
  @BuiltValueField(wireName: 'medium')
  String get medium;
  @BuiltValueField(wireName: 'large')
  String get large;
  String toJson() {
    return json
        .encode(serializers.serializeWith(ProfileImage.serializer, this));
  }

  static ProfileImage fromJson(String jsonString) {
    return serializers.deserializeWith(
        ProfileImage.serializer, json.decode(jsonString));
  }

  static Serializer<ProfileImage> get serializer => _$profileImageSerializer;
}
