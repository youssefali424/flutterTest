// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Collection> _$collectionSerializer = new _$CollectionSerializer();
Serializer<CoverPhoto> _$coverPhotoSerializer = new _$CoverPhotoSerializer();
Serializer<User> _$userSerializer = new _$UserSerializer();
Serializer<Links> _$linksSerializer = new _$LinksSerializer();
Serializer<Urls> _$urlsSerializer = new _$UrlsSerializer();
Serializer<ProfileImage> _$profileImageSerializer =
    new _$ProfileImageSerializer();

class _$CollectionSerializer implements StructuredSerializer<Collection> {
  @override
  final Iterable<Type> types = const [Collection, _$Collection];
  @override
  final String wireName = 'Collection';

  @override
  Iterable<Object> serialize(Serializers serializers, Collection object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'total_photos',
      serializers.serialize(object.totalPhotos,
          specifiedType: const FullType(int)),
      'private',
      serializers.serialize(object.private,
          specifiedType: const FullType(bool)),
      'cover_photo',
      serializers.serialize(object.coverPhoto,
          specifiedType: const FullType(CoverPhoto)),
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(User)),
      'links',
      serializers.serialize(object.links, specifiedType: const FullType(Links)),
    ];
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    if (object.publishedAt != null) {
      result
        ..add('published_at')
        ..add(serializers.serialize(object.publishedAt,
            specifiedType: const FullType(String)));
    }
    if (object.updatedAt != null) {
      result
        ..add('updated_at')
        ..add(serializers.serialize(object.updatedAt,
            specifiedType: const FullType(String)));
    }
    if (object.shareKey != null) {
      result
        ..add('share_key')
        ..add(serializers.serialize(object.shareKey,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Collection deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CollectionBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'published_at':
          result.publishedAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'total_photos':
          result.totalPhotos = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'private':
          result.private = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'share_key':
          result.shareKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'cover_photo':
          result.coverPhoto.replace(serializers.deserialize(value,
              specifiedType: const FullType(CoverPhoto)) as CoverPhoto);
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(User)) as User);
          break;
        case 'links':
          result.links.replace(serializers.deserialize(value,
              specifiedType: const FullType(Links)) as Links);
          break;
      }
    }

    return result.build();
  }
}

class _$CoverPhotoSerializer implements StructuredSerializer<CoverPhoto> {
  @override
  final Iterable<Type> types = const [CoverPhoto, _$CoverPhoto];
  @override
  final String wireName = 'CoverPhoto';

  @override
  Iterable<Object> serialize(Serializers serializers, CoverPhoto object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'width',
      serializers.serialize(object.width, specifiedType: const FullType(int)),
      'height',
      serializers.serialize(object.height, specifiedType: const FullType(int)),
      'color',
      serializers.serialize(object.color,
          specifiedType: const FullType(String)),
      'likes',
      serializers.serialize(object.likes, specifiedType: const FullType(int)),
      'liked_by_user',
      serializers.serialize(object.likedByUser,
          specifiedType: const FullType(bool)),
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(User)),
      'urls',
      serializers.serialize(object.urls, specifiedType: const FullType(Urls)),
      'links',
      serializers.serialize(object.links, specifiedType: const FullType(Links)),
    ];
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  CoverPhoto deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CoverPhotoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'width':
          result.width = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'height':
          result.height = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'color':
          result.color = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'likes':
          result.likes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'liked_by_user':
          result.likedByUser = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(User)) as User);
          break;
        case 'urls':
          result.urls.replace(serializers.deserialize(value,
              specifiedType: const FullType(Urls)) as Urls);
          break;
        case 'links':
          result.links.replace(serializers.deserialize(value,
              specifiedType: const FullType(Links)) as Links);
          break;
      }
    }

    return result.build();
  }
}

class _$UserSerializer implements StructuredSerializer<User> {
  @override
  final Iterable<Type> types = const [User, _$User];
  @override
  final String wireName = 'User';

  @override
  Iterable<Object> serialize(Serializers serializers, User object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'updated_at',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(String)),
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'total_likes',
      serializers.serialize(object.totalLikes,
          specifiedType: const FullType(int)),
      'total_photos',
      serializers.serialize(object.totalPhotos,
          specifiedType: const FullType(int)),
      'total_collections',
      serializers.serialize(object.totalCollections,
          specifiedType: const FullType(int)),
      'profile_image',
      serializers.serialize(object.profileImage,
          specifiedType: const FullType(ProfileImage)),
    ];
    if (object.portfolioUrl != null) {
      result
        ..add('portfolio_url')
        ..add(serializers.serialize(object.portfolioUrl,
            specifiedType: const FullType(String)));
    }
    if (object.bio != null) {
      result
        ..add('bio')
        ..add(serializers.serialize(object.bio,
            specifiedType: const FullType(String)));
    }
    if (object.location != null) {
      result
        ..add('location')
        ..add(serializers.serialize(object.location,
            specifiedType: const FullType(String)));
    }
    if (object.links != null) {
      result
        ..add('links')
        ..add(serializers.serialize(object.links,
            specifiedType: const FullType(Links)));
    }
    return result;
  }

  @override
  User deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'portfolio_url':
          result.portfolioUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'bio':
          result.bio = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'location':
          result.location = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'total_likes':
          result.totalLikes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'total_photos':
          result.totalPhotos = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'total_collections':
          result.totalCollections = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'profile_image':
          result.profileImage.replace(serializers.deserialize(value,
              specifiedType: const FullType(ProfileImage)) as ProfileImage);
          break;
        case 'links':
          result.links.replace(serializers.deserialize(value,
              specifiedType: const FullType(Links)) as Links);
          break;
      }
    }

    return result.build();
  }
}

class _$LinksSerializer implements StructuredSerializer<Links> {
  @override
  final Iterable<Type> types = const [Links, _$Links];
  @override
  final String wireName = 'Links';

  @override
  Iterable<Object> serialize(Serializers serializers, Links object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.self != null) {
      result
        ..add('self')
        ..add(serializers.serialize(object.self,
            specifiedType: const FullType(String)));
    }
    if (object.html != null) {
      result
        ..add('html')
        ..add(serializers.serialize(object.html,
            specifiedType: const FullType(String)));
    }
    if (object.photos != null) {
      result
        ..add('photos')
        ..add(serializers.serialize(object.photos,
            specifiedType: const FullType(String)));
    }
    if (object.related != null) {
      result
        ..add('related')
        ..add(serializers.serialize(object.related,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Links deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LinksBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'self':
          result.self = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'html':
          result.html = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'photos':
          result.photos = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'related':
          result.related = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$UrlsSerializer implements StructuredSerializer<Urls> {
  @override
  final Iterable<Type> types = const [Urls, _$Urls];
  @override
  final String wireName = 'Urls';

  @override
  Iterable<Object> serialize(Serializers serializers, Urls object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'raw',
      serializers.serialize(object.raw, specifiedType: const FullType(String)),
      'full',
      serializers.serialize(object.full, specifiedType: const FullType(String)),
      'regular',
      serializers.serialize(object.regular,
          specifiedType: const FullType(String)),
      'small',
      serializers.serialize(object.small,
          specifiedType: const FullType(String)),
      'thumb',
      serializers.serialize(object.thumb,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Urls deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UrlsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'raw':
          result.raw = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'full':
          result.full = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'regular':
          result.regular = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'small':
          result.small = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'thumb':
          result.thumb = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ProfileImageSerializer implements StructuredSerializer<ProfileImage> {
  @override
  final Iterable<Type> types = const [ProfileImage, _$ProfileImage];
  @override
  final String wireName = 'ProfileImage';

  @override
  Iterable<Object> serialize(Serializers serializers, ProfileImage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'small',
      serializers.serialize(object.small,
          specifiedType: const FullType(String)),
      'medium',
      serializers.serialize(object.medium,
          specifiedType: const FullType(String)),
      'large',
      serializers.serialize(object.large,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ProfileImage deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProfileImageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'small':
          result.small = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'medium':
          result.medium = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'large':
          result.large = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Collection extends Collection {
  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String publishedAt;
  @override
  final String updatedAt;
  @override
  final int totalPhotos;
  @override
  final bool private;
  @override
  final String shareKey;
  @override
  final CoverPhoto coverPhoto;
  @override
  final User user;
  @override
  final Links links;

  factory _$Collection([void Function(CollectionBuilder) updates]) =>
      (new CollectionBuilder()..update(updates)).build();

  _$Collection._(
      {this.id,
      this.title,
      this.description,
      this.publishedAt,
      this.updatedAt,
      this.totalPhotos,
      this.private,
      this.shareKey,
      this.coverPhoto,
      this.user,
      this.links})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Collection', 'id');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Collection', 'title');
    }
    if (totalPhotos == null) {
      throw new BuiltValueNullFieldError('Collection', 'totalPhotos');
    }
    if (private == null) {
      throw new BuiltValueNullFieldError('Collection', 'private');
    }
    if (coverPhoto == null) {
      throw new BuiltValueNullFieldError('Collection', 'coverPhoto');
    }
    if (user == null) {
      throw new BuiltValueNullFieldError('Collection', 'user');
    }
    if (links == null) {
      throw new BuiltValueNullFieldError('Collection', 'links');
    }
  }

  @override
  Collection rebuild(void Function(CollectionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CollectionBuilder toBuilder() => new CollectionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Collection &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        publishedAt == other.publishedAt &&
        updatedAt == other.updatedAt &&
        totalPhotos == other.totalPhotos &&
        private == other.private &&
        shareKey == other.shareKey &&
        coverPhoto == other.coverPhoto &&
        user == other.user &&
        links == other.links;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc($jc(0, id.hashCode),
                                            title.hashCode),
                                        description.hashCode),
                                    publishedAt.hashCode),
                                updatedAt.hashCode),
                            totalPhotos.hashCode),
                        private.hashCode),
                    shareKey.hashCode),
                coverPhoto.hashCode),
            user.hashCode),
        links.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Collection')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('publishedAt', publishedAt)
          ..add('updatedAt', updatedAt)
          ..add('totalPhotos', totalPhotos)
          ..add('private', private)
          ..add('shareKey', shareKey)
          ..add('coverPhoto', coverPhoto)
          ..add('user', user)
          ..add('links', links))
        .toString();
  }
}

class CollectionBuilder implements Builder<Collection, CollectionBuilder> {
  _$Collection _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _publishedAt;
  String get publishedAt => _$this._publishedAt;
  set publishedAt(String publishedAt) => _$this._publishedAt = publishedAt;

  String _updatedAt;
  String get updatedAt => _$this._updatedAt;
  set updatedAt(String updatedAt) => _$this._updatedAt = updatedAt;

  int _totalPhotos;
  int get totalPhotos => _$this._totalPhotos;
  set totalPhotos(int totalPhotos) => _$this._totalPhotos = totalPhotos;

  bool _private;
  bool get private => _$this._private;
  set private(bool private) => _$this._private = private;

  String _shareKey;
  String get shareKey => _$this._shareKey;
  set shareKey(String shareKey) => _$this._shareKey = shareKey;

  CoverPhotoBuilder _coverPhoto;
  CoverPhotoBuilder get coverPhoto =>
      _$this._coverPhoto ??= new CoverPhotoBuilder();
  set coverPhoto(CoverPhotoBuilder coverPhoto) =>
      _$this._coverPhoto = coverPhoto;

  UserBuilder _user;
  UserBuilder get user => _$this._user ??= new UserBuilder();
  set user(UserBuilder user) => _$this._user = user;

  LinksBuilder _links;
  LinksBuilder get links => _$this._links ??= new LinksBuilder();
  set links(LinksBuilder links) => _$this._links = links;

  CollectionBuilder();

  CollectionBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _title = _$v.title;
      _description = _$v.description;
      _publishedAt = _$v.publishedAt;
      _updatedAt = _$v.updatedAt;
      _totalPhotos = _$v.totalPhotos;
      _private = _$v.private;
      _shareKey = _$v.shareKey;
      _coverPhoto = _$v.coverPhoto?.toBuilder();
      _user = _$v.user?.toBuilder();
      _links = _$v.links?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Collection other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Collection;
  }

  @override
  void update(void Function(CollectionBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Collection build() {
    _$Collection _$result;
    try {
      _$result = _$v ??
          new _$Collection._(
              id: id,
              title: title,
              description: description,
              publishedAt: publishedAt,
              updatedAt: updatedAt,
              totalPhotos: totalPhotos,
              private: private,
              shareKey: shareKey,
              coverPhoto: coverPhoto.build(),
              user: user.build(),
              links: links.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'coverPhoto';
        coverPhoto.build();
        _$failedField = 'user';
        user.build();
        _$failedField = 'links';
        links.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Collection', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CoverPhoto extends CoverPhoto {
  @override
  final String id;
  @override
  final int width;
  @override
  final int height;
  @override
  final String color;
  @override
  final int likes;
  @override
  final bool likedByUser;
  @override
  final String description;
  @override
  final User user;
  @override
  final Urls urls;
  @override
  final Links links;

  factory _$CoverPhoto([void Function(CoverPhotoBuilder) updates]) =>
      (new CoverPhotoBuilder()..update(updates)).build();

  _$CoverPhoto._(
      {this.id,
      this.width,
      this.height,
      this.color,
      this.likes,
      this.likedByUser,
      this.description,
      this.user,
      this.urls,
      this.links})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('CoverPhoto', 'id');
    }
    if (width == null) {
      throw new BuiltValueNullFieldError('CoverPhoto', 'width');
    }
    if (height == null) {
      throw new BuiltValueNullFieldError('CoverPhoto', 'height');
    }
    if (color == null) {
      throw new BuiltValueNullFieldError('CoverPhoto', 'color');
    }
    if (likes == null) {
      throw new BuiltValueNullFieldError('CoverPhoto', 'likes');
    }
    if (likedByUser == null) {
      throw new BuiltValueNullFieldError('CoverPhoto', 'likedByUser');
    }
    if (user == null) {
      throw new BuiltValueNullFieldError('CoverPhoto', 'user');
    }
    if (urls == null) {
      throw new BuiltValueNullFieldError('CoverPhoto', 'urls');
    }
    if (links == null) {
      throw new BuiltValueNullFieldError('CoverPhoto', 'links');
    }
  }

  @override
  CoverPhoto rebuild(void Function(CoverPhotoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CoverPhotoBuilder toBuilder() => new CoverPhotoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CoverPhoto &&
        id == other.id &&
        width == other.width &&
        height == other.height &&
        color == other.color &&
        likes == other.likes &&
        likedByUser == other.likedByUser &&
        description == other.description &&
        user == other.user &&
        urls == other.urls &&
        links == other.links;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc($jc(0, id.hashCode), width.hashCode),
                                    height.hashCode),
                                color.hashCode),
                            likes.hashCode),
                        likedByUser.hashCode),
                    description.hashCode),
                user.hashCode),
            urls.hashCode),
        links.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CoverPhoto')
          ..add('id', id)
          ..add('width', width)
          ..add('height', height)
          ..add('color', color)
          ..add('likes', likes)
          ..add('likedByUser', likedByUser)
          ..add('description', description)
          ..add('user', user)
          ..add('urls', urls)
          ..add('links', links))
        .toString();
  }
}

class CoverPhotoBuilder implements Builder<CoverPhoto, CoverPhotoBuilder> {
  _$CoverPhoto _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  int _width;
  int get width => _$this._width;
  set width(int width) => _$this._width = width;

  int _height;
  int get height => _$this._height;
  set height(int height) => _$this._height = height;

  String _color;
  String get color => _$this._color;
  set color(String color) => _$this._color = color;

  int _likes;
  int get likes => _$this._likes;
  set likes(int likes) => _$this._likes = likes;

  bool _likedByUser;
  bool get likedByUser => _$this._likedByUser;
  set likedByUser(bool likedByUser) => _$this._likedByUser = likedByUser;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  UserBuilder _user;
  UserBuilder get user => _$this._user ??= new UserBuilder();
  set user(UserBuilder user) => _$this._user = user;

  UrlsBuilder _urls;
  UrlsBuilder get urls => _$this._urls ??= new UrlsBuilder();
  set urls(UrlsBuilder urls) => _$this._urls = urls;

  LinksBuilder _links;
  LinksBuilder get links => _$this._links ??= new LinksBuilder();
  set links(LinksBuilder links) => _$this._links = links;

  CoverPhotoBuilder();

  CoverPhotoBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _width = _$v.width;
      _height = _$v.height;
      _color = _$v.color;
      _likes = _$v.likes;
      _likedByUser = _$v.likedByUser;
      _description = _$v.description;
      _user = _$v.user?.toBuilder();
      _urls = _$v.urls?.toBuilder();
      _links = _$v.links?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CoverPhoto other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CoverPhoto;
  }

  @override
  void update(void Function(CoverPhotoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CoverPhoto build() {
    _$CoverPhoto _$result;
    try {
      _$result = _$v ??
          new _$CoverPhoto._(
              id: id,
              width: width,
              height: height,
              color: color,
              likes: likes,
              likedByUser: likedByUser,
              description: description,
              user: user.build(),
              urls: urls.build(),
              links: links.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
        _$failedField = 'urls';
        urls.build();
        _$failedField = 'links';
        links.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CoverPhoto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$User extends User {
  @override
  final String id;
  @override
  final String updatedAt;
  @override
  final String username;
  @override
  final String name;
  @override
  final String portfolioUrl;
  @override
  final String bio;
  @override
  final String location;
  @override
  final int totalLikes;
  @override
  final int totalPhotos;
  @override
  final int totalCollections;
  @override
  final ProfileImage profileImage;
  @override
  final Links links;

  factory _$User([void Function(UserBuilder) updates]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._(
      {this.id,
      this.updatedAt,
      this.username,
      this.name,
      this.portfolioUrl,
      this.bio,
      this.location,
      this.totalLikes,
      this.totalPhotos,
      this.totalCollections,
      this.profileImage,
      this.links})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('User', 'id');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('User', 'updatedAt');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('User', 'username');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('User', 'name');
    }
    if (totalLikes == null) {
      throw new BuiltValueNullFieldError('User', 'totalLikes');
    }
    if (totalPhotos == null) {
      throw new BuiltValueNullFieldError('User', 'totalPhotos');
    }
    if (totalCollections == null) {
      throw new BuiltValueNullFieldError('User', 'totalCollections');
    }
    if (profileImage == null) {
      throw new BuiltValueNullFieldError('User', 'profileImage');
    }
  }

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        id == other.id &&
        updatedAt == other.updatedAt &&
        username == other.username &&
        name == other.name &&
        portfolioUrl == other.portfolioUrl &&
        bio == other.bio &&
        location == other.location &&
        totalLikes == other.totalLikes &&
        totalPhotos == other.totalPhotos &&
        totalCollections == other.totalCollections &&
        profileImage == other.profileImage &&
        links == other.links;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc($jc(0, id.hashCode),
                                                updatedAt.hashCode),
                                            username.hashCode),
                                        name.hashCode),
                                    portfolioUrl.hashCode),
                                bio.hashCode),
                            location.hashCode),
                        totalLikes.hashCode),
                    totalPhotos.hashCode),
                totalCollections.hashCode),
            profileImage.hashCode),
        links.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')
          ..add('id', id)
          ..add('updatedAt', updatedAt)
          ..add('username', username)
          ..add('name', name)
          ..add('portfolioUrl', portfolioUrl)
          ..add('bio', bio)
          ..add('location', location)
          ..add('totalLikes', totalLikes)
          ..add('totalPhotos', totalPhotos)
          ..add('totalCollections', totalCollections)
          ..add('profileImage', profileImage)
          ..add('links', links))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _updatedAt;
  String get updatedAt => _$this._updatedAt;
  set updatedAt(String updatedAt) => _$this._updatedAt = updatedAt;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _portfolioUrl;
  String get portfolioUrl => _$this._portfolioUrl;
  set portfolioUrl(String portfolioUrl) => _$this._portfolioUrl = portfolioUrl;

  String _bio;
  String get bio => _$this._bio;
  set bio(String bio) => _$this._bio = bio;

  String _location;
  String get location => _$this._location;
  set location(String location) => _$this._location = location;

  int _totalLikes;
  int get totalLikes => _$this._totalLikes;
  set totalLikes(int totalLikes) => _$this._totalLikes = totalLikes;

  int _totalPhotos;
  int get totalPhotos => _$this._totalPhotos;
  set totalPhotos(int totalPhotos) => _$this._totalPhotos = totalPhotos;

  int _totalCollections;
  int get totalCollections => _$this._totalCollections;
  set totalCollections(int totalCollections) =>
      _$this._totalCollections = totalCollections;

  ProfileImageBuilder _profileImage;
  ProfileImageBuilder get profileImage =>
      _$this._profileImage ??= new ProfileImageBuilder();
  set profileImage(ProfileImageBuilder profileImage) =>
      _$this._profileImage = profileImage;

  LinksBuilder _links;
  LinksBuilder get links => _$this._links ??= new LinksBuilder();
  set links(LinksBuilder links) => _$this._links = links;

  UserBuilder();

  UserBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _updatedAt = _$v.updatedAt;
      _username = _$v.username;
      _name = _$v.name;
      _portfolioUrl = _$v.portfolioUrl;
      _bio = _$v.bio;
      _location = _$v.location;
      _totalLikes = _$v.totalLikes;
      _totalPhotos = _$v.totalPhotos;
      _totalCollections = _$v.totalCollections;
      _profileImage = _$v.profileImage?.toBuilder();
      _links = _$v.links?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$User build() {
    _$User _$result;
    try {
      _$result = _$v ??
          new _$User._(
              id: id,
              updatedAt: updatedAt,
              username: username,
              name: name,
              portfolioUrl: portfolioUrl,
              bio: bio,
              location: location,
              totalLikes: totalLikes,
              totalPhotos: totalPhotos,
              totalCollections: totalCollections,
              profileImage: profileImage.build(),
              links: _links?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'profileImage';
        profileImage.build();
        _$failedField = 'links';
        _links?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'User', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Links extends Links {
  @override
  final String self;
  @override
  final String html;
  @override
  final String photos;
  @override
  final String related;

  factory _$Links([void Function(LinksBuilder) updates]) =>
      (new LinksBuilder()..update(updates)).build();

  _$Links._({this.self, this.html, this.photos, this.related}) : super._();

  @override
  Links rebuild(void Function(LinksBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinksBuilder toBuilder() => new LinksBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Links &&
        self == other.self &&
        html == other.html &&
        photos == other.photos &&
        related == other.related;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, self.hashCode), html.hashCode), photos.hashCode),
        related.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Links')
          ..add('self', self)
          ..add('html', html)
          ..add('photos', photos)
          ..add('related', related))
        .toString();
  }
}

class LinksBuilder implements Builder<Links, LinksBuilder> {
  _$Links _$v;

  String _self;
  String get self => _$this._self;
  set self(String self) => _$this._self = self;

  String _html;
  String get html => _$this._html;
  set html(String html) => _$this._html = html;

  String _photos;
  String get photos => _$this._photos;
  set photos(String photos) => _$this._photos = photos;

  String _related;
  String get related => _$this._related;
  set related(String related) => _$this._related = related;

  LinksBuilder();

  LinksBuilder get _$this {
    if (_$v != null) {
      _self = _$v.self;
      _html = _$v.html;
      _photos = _$v.photos;
      _related = _$v.related;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Links other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Links;
  }

  @override
  void update(void Function(LinksBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Links build() {
    final _$result = _$v ??
        new _$Links._(self: self, html: html, photos: photos, related: related);
    replace(_$result);
    return _$result;
  }
}

class _$Urls extends Urls {
  @override
  final String raw;
  @override
  final String full;
  @override
  final String regular;
  @override
  final String small;
  @override
  final String thumb;

  factory _$Urls([void Function(UrlsBuilder) updates]) =>
      (new UrlsBuilder()..update(updates)).build();

  _$Urls._({this.raw, this.full, this.regular, this.small, this.thumb})
      : super._() {
    if (raw == null) {
      throw new BuiltValueNullFieldError('Urls', 'raw');
    }
    if (full == null) {
      throw new BuiltValueNullFieldError('Urls', 'full');
    }
    if (regular == null) {
      throw new BuiltValueNullFieldError('Urls', 'regular');
    }
    if (small == null) {
      throw new BuiltValueNullFieldError('Urls', 'small');
    }
    if (thumb == null) {
      throw new BuiltValueNullFieldError('Urls', 'thumb');
    }
  }

  @override
  Urls rebuild(void Function(UrlsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UrlsBuilder toBuilder() => new UrlsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Urls &&
        raw == other.raw &&
        full == other.full &&
        regular == other.regular &&
        small == other.small &&
        thumb == other.thumb;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, raw.hashCode), full.hashCode), regular.hashCode),
            small.hashCode),
        thumb.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Urls')
          ..add('raw', raw)
          ..add('full', full)
          ..add('regular', regular)
          ..add('small', small)
          ..add('thumb', thumb))
        .toString();
  }
}

class UrlsBuilder implements Builder<Urls, UrlsBuilder> {
  _$Urls _$v;

  String _raw;
  String get raw => _$this._raw;
  set raw(String raw) => _$this._raw = raw;

  String _full;
  String get full => _$this._full;
  set full(String full) => _$this._full = full;

  String _regular;
  String get regular => _$this._regular;
  set regular(String regular) => _$this._regular = regular;

  String _small;
  String get small => _$this._small;
  set small(String small) => _$this._small = small;

  String _thumb;
  String get thumb => _$this._thumb;
  set thumb(String thumb) => _$this._thumb = thumb;

  UrlsBuilder();

  UrlsBuilder get _$this {
    if (_$v != null) {
      _raw = _$v.raw;
      _full = _$v.full;
      _regular = _$v.regular;
      _small = _$v.small;
      _thumb = _$v.thumb;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Urls other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Urls;
  }

  @override
  void update(void Function(UrlsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Urls build() {
    final _$result = _$v ??
        new _$Urls._(
            raw: raw, full: full, regular: regular, small: small, thumb: thumb);
    replace(_$result);
    return _$result;
  }
}

class _$ProfileImage extends ProfileImage {
  @override
  final String small;
  @override
  final String medium;
  @override
  final String large;

  factory _$ProfileImage([void Function(ProfileImageBuilder) updates]) =>
      (new ProfileImageBuilder()..update(updates)).build();

  _$ProfileImage._({this.small, this.medium, this.large}) : super._() {
    if (small == null) {
      throw new BuiltValueNullFieldError('ProfileImage', 'small');
    }
    if (medium == null) {
      throw new BuiltValueNullFieldError('ProfileImage', 'medium');
    }
    if (large == null) {
      throw new BuiltValueNullFieldError('ProfileImage', 'large');
    }
  }

  @override
  ProfileImage rebuild(void Function(ProfileImageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileImageBuilder toBuilder() => new ProfileImageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfileImage &&
        small == other.small &&
        medium == other.medium &&
        large == other.large;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, small.hashCode), medium.hashCode), large.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProfileImage')
          ..add('small', small)
          ..add('medium', medium)
          ..add('large', large))
        .toString();
  }
}

class ProfileImageBuilder
    implements Builder<ProfileImage, ProfileImageBuilder> {
  _$ProfileImage _$v;

  String _small;
  String get small => _$this._small;
  set small(String small) => _$this._small = small;

  String _medium;
  String get medium => _$this._medium;
  set medium(String medium) => _$this._medium = medium;

  String _large;
  String get large => _$this._large;
  set large(String large) => _$this._large = large;

  ProfileImageBuilder();

  ProfileImageBuilder get _$this {
    if (_$v != null) {
      _small = _$v.small;
      _medium = _$v.medium;
      _large = _$v.large;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProfileImage other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProfileImage;
  }

  @override
  void update(void Function(ProfileImageBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProfileImage build() {
    final _$result =
        _$v ?? new _$ProfileImage._(small: small, medium: medium, large: large);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
