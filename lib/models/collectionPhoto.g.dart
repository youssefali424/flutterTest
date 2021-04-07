// GENERATED CODE - DO NOT MODIFY BY HAND

part of collection_photo;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CollectionPhoto> _$collectionPhotoSerializer =
    new _$CollectionPhotoSerializer();
Serializer<PhotoLinks> _$photoLinksSerializer = new _$PhotoLinksSerializer();

class _$CollectionPhotoSerializer
    implements StructuredSerializer<CollectionPhoto> {
  @override
  final Iterable<Type> types = const [CollectionPhoto, _$CollectionPhoto];
  @override
  final String wireName = 'CollectionPhoto';

  @override
  Iterable<Object> serialize(Serializers serializers, CollectionPhoto object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'created_at',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(String)),
      'updated_at',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(String)),
      'width',
      serializers.serialize(object.width, specifiedType: const FullType(int)),
      'height',
      serializers.serialize(object.height, specifiedType: const FullType(int)),
      'color',
      serializers.serialize(object.color,
          specifiedType: const FullType(String)),
      'urls',
      serializers.serialize(object.urls, specifiedType: const FullType(Urls)),
      'links',
      serializers.serialize(object.links,
          specifiedType: const FullType(PhotoLinks)),
      'likes',
      serializers.serialize(object.likes, specifiedType: const FullType(int)),
      'liked_by_user',
      serializers.serialize(object.likedByUser,
          specifiedType: const FullType(bool)),
      'user',
      serializers.serialize(object.user, specifiedType: const FullType(User)),
    ];
    if (object.promotedAt != null) {
      result
        ..add('promoted_at')
        ..add(serializers.serialize(object.promotedAt,
            specifiedType: const FullType(String)));
    }
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    if (object.altDescription != null) {
      result
        ..add('alt_description')
        ..add(serializers.serialize(object.altDescription,
            specifiedType: const FullType(String)));
    }
    if (object.categories != null) {
      result
        ..add('categories')
        ..add(serializers.serialize(object.categories,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.currentUserCollections != null) {
      result
        ..add('current_user_collections')
        ..add(serializers.serialize(object.currentUserCollections,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    return result;
  }

  @override
  CollectionPhoto deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CollectionPhotoBuilder();

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
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'promoted_at':
          result.promotedAt = serializers.deserialize(value,
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
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'alt_description':
          result.altDescription = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'urls':
          result.urls.replace(serializers.deserialize(value,
              specifiedType: const FullType(Urls)) as Urls);
          break;
        case 'links':
          result.links.replace(serializers.deserialize(value,
              specifiedType: const FullType(PhotoLinks)) as PhotoLinks);
          break;
        case 'categories':
          result.categories.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'likes':
          result.likes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'liked_by_user':
          result.likedByUser = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'current_user_collections':
          result.currentUserCollections.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))
              as BuiltList<Object>);
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(User)) as User);
          break;
      }
    }

    return result.build();
  }
}

class _$PhotoLinksSerializer implements StructuredSerializer<PhotoLinks> {
  @override
  final Iterable<Type> types = const [PhotoLinks, _$PhotoLinks];
  @override
  final String wireName = 'PhotoLinks';

  @override
  Iterable<Object> serialize(Serializers serializers, PhotoLinks object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'self',
      serializers.serialize(object.self, specifiedType: const FullType(String)),
      'html',
      serializers.serialize(object.html, specifiedType: const FullType(String)),
      'download',
      serializers.serialize(object.download,
          specifiedType: const FullType(String)),
      'download_location',
      serializers.serialize(object.downloadLocation,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  PhotoLinks deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PhotoLinksBuilder();

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
        case 'download':
          result.download = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'download_location':
          result.downloadLocation = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$CollectionPhoto extends CollectionPhoto {
  @override
  final String id;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final String promotedAt;
  @override
  final int width;
  @override
  final int height;
  @override
  final String color;
  @override
  final String description;
  @override
  final String altDescription;
  @override
  final Urls urls;
  @override
  final PhotoLinks links;
  @override
  final BuiltList<String> categories;
  @override
  final int likes;
  @override
  final bool likedByUser;
  @override
  final BuiltList<int> currentUserCollections;
  @override
  final User user;

  factory _$CollectionPhoto([void Function(CollectionPhotoBuilder) updates]) =>
      (new CollectionPhotoBuilder()..update(updates)).build();

  _$CollectionPhoto._(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.promotedAt,
      this.width,
      this.height,
      this.color,
      this.description,
      this.altDescription,
      this.urls,
      this.links,
      this.categories,
      this.likes,
      this.likedByUser,
      this.currentUserCollections,
      this.user})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('CollectionPhoto', 'id');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('CollectionPhoto', 'createdAt');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('CollectionPhoto', 'updatedAt');
    }
    if (width == null) {
      throw new BuiltValueNullFieldError('CollectionPhoto', 'width');
    }
    if (height == null) {
      throw new BuiltValueNullFieldError('CollectionPhoto', 'height');
    }
    if (color == null) {
      throw new BuiltValueNullFieldError('CollectionPhoto', 'color');
    }
    if (urls == null) {
      throw new BuiltValueNullFieldError('CollectionPhoto', 'urls');
    }
    if (links == null) {
      throw new BuiltValueNullFieldError('CollectionPhoto', 'links');
    }
    if (likes == null) {
      throw new BuiltValueNullFieldError('CollectionPhoto', 'likes');
    }
    if (likedByUser == null) {
      throw new BuiltValueNullFieldError('CollectionPhoto', 'likedByUser');
    }
    if (user == null) {
      throw new BuiltValueNullFieldError('CollectionPhoto', 'user');
    }
  }

  @override
  CollectionPhoto rebuild(void Function(CollectionPhotoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CollectionPhotoBuilder toBuilder() =>
      new CollectionPhotoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CollectionPhoto &&
        id == other.id &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        promotedAt == other.promotedAt &&
        width == other.width &&
        height == other.height &&
        color == other.color &&
        description == other.description &&
        altDescription == other.altDescription &&
        urls == other.urls &&
        links == other.links &&
        categories == other.categories &&
        likes == other.likes &&
        likedByUser == other.likedByUser &&
        currentUserCollections == other.currentUserCollections &&
        user == other.user;
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
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    0,
                                                                    id
                                                                        .hashCode),
                                                                createdAt
                                                                    .hashCode),
                                                            updatedAt.hashCode),
                                                        promotedAt.hashCode),
                                                    width.hashCode),
                                                height.hashCode),
                                            color.hashCode),
                                        description.hashCode),
                                    altDescription.hashCode),
                                urls.hashCode),
                            links.hashCode),
                        categories.hashCode),
                    likes.hashCode),
                likedByUser.hashCode),
            currentUserCollections.hashCode),
        user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CollectionPhoto')
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('promotedAt', promotedAt)
          ..add('width', width)
          ..add('height', height)
          ..add('color', color)
          ..add('description', description)
          ..add('altDescription', altDescription)
          ..add('urls', urls)
          ..add('links', links)
          ..add('categories', categories)
          ..add('likes', likes)
          ..add('likedByUser', likedByUser)
          ..add('currentUserCollections', currentUserCollections)
          ..add('user', user))
        .toString();
  }
}

class CollectionPhotoBuilder
    implements Builder<CollectionPhoto, CollectionPhotoBuilder> {
  _$CollectionPhoto _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _createdAt;
  String get createdAt => _$this._createdAt;
  set createdAt(String createdAt) => _$this._createdAt = createdAt;

  String _updatedAt;
  String get updatedAt => _$this._updatedAt;
  set updatedAt(String updatedAt) => _$this._updatedAt = updatedAt;

  String _promotedAt;
  String get promotedAt => _$this._promotedAt;
  set promotedAt(String promotedAt) => _$this._promotedAt = promotedAt;

  int _width;
  int get width => _$this._width;
  set width(int width) => _$this._width = width;

  int _height;
  int get height => _$this._height;
  set height(int height) => _$this._height = height;

  String _color;
  String get color => _$this._color;
  set color(String color) => _$this._color = color;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _altDescription;
  String get altDescription => _$this._altDescription;
  set altDescription(String altDescription) =>
      _$this._altDescription = altDescription;

  UrlsBuilder _urls;
  UrlsBuilder get urls => _$this._urls ??= new UrlsBuilder();
  set urls(UrlsBuilder urls) => _$this._urls = urls;

  PhotoLinksBuilder _links;
  PhotoLinksBuilder get links => _$this._links ??= new PhotoLinksBuilder();
  set links(PhotoLinksBuilder links) => _$this._links = links;

  ListBuilder<String> _categories;
  ListBuilder<String> get categories =>
      _$this._categories ??= new ListBuilder<String>();
  set categories(ListBuilder<String> categories) =>
      _$this._categories = categories;

  int _likes;
  int get likes => _$this._likes;
  set likes(int likes) => _$this._likes = likes;

  bool _likedByUser;
  bool get likedByUser => _$this._likedByUser;
  set likedByUser(bool likedByUser) => _$this._likedByUser = likedByUser;

  ListBuilder<int> _currentUserCollections;
  ListBuilder<int> get currentUserCollections =>
      _$this._currentUserCollections ??= new ListBuilder<int>();
  set currentUserCollections(ListBuilder<int> currentUserCollections) =>
      _$this._currentUserCollections = currentUserCollections;

  UserBuilder _user;
  UserBuilder get user => _$this._user ??= new UserBuilder();
  set user(UserBuilder user) => _$this._user = user;

  CollectionPhotoBuilder();

  CollectionPhotoBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _promotedAt = _$v.promotedAt;
      _width = _$v.width;
      _height = _$v.height;
      _color = _$v.color;
      _description = _$v.description;
      _altDescription = _$v.altDescription;
      _urls = _$v.urls?.toBuilder();
      _links = _$v.links?.toBuilder();
      _categories = _$v.categories?.toBuilder();
      _likes = _$v.likes;
      _likedByUser = _$v.likedByUser;
      _currentUserCollections = _$v.currentUserCollections?.toBuilder();
      _user = _$v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CollectionPhoto other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CollectionPhoto;
  }

  @override
  void update(void Function(CollectionPhotoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CollectionPhoto build() {
    _$CollectionPhoto _$result;
    try {
      _$result = _$v ??
          new _$CollectionPhoto._(
              id: id,
              createdAt: createdAt,
              updatedAt: updatedAt,
              promotedAt: promotedAt,
              width: width,
              height: height,
              color: color,
              description: description,
              altDescription: altDescription,
              urls: urls.build(),
              links: links.build(),
              categories: _categories?.build(),
              likes: likes,
              likedByUser: likedByUser,
              currentUserCollections: _currentUserCollections?.build(),
              user: user.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'urls';
        urls.build();
        _$failedField = 'links';
        links.build();
        _$failedField = 'categories';
        _categories?.build();

        _$failedField = 'currentUserCollections';
        _currentUserCollections?.build();
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CollectionPhoto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PhotoLinks extends PhotoLinks {
  @override
  final String self;
  @override
  final String html;
  @override
  final String download;
  @override
  final String downloadLocation;

  factory _$PhotoLinks([void Function(PhotoLinksBuilder) updates]) =>
      (new PhotoLinksBuilder()..update(updates)).build();

  _$PhotoLinks._({this.self, this.html, this.download, this.downloadLocation})
      : super._() {
    if (self == null) {
      throw new BuiltValueNullFieldError('PhotoLinks', 'self');
    }
    if (html == null) {
      throw new BuiltValueNullFieldError('PhotoLinks', 'html');
    }
    if (download == null) {
      throw new BuiltValueNullFieldError('PhotoLinks', 'download');
    }
    if (downloadLocation == null) {
      throw new BuiltValueNullFieldError('PhotoLinks', 'downloadLocation');
    }
  }

  @override
  PhotoLinks rebuild(void Function(PhotoLinksBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PhotoLinksBuilder toBuilder() => new PhotoLinksBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PhotoLinks &&
        self == other.self &&
        html == other.html &&
        download == other.download &&
        downloadLocation == other.downloadLocation;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, self.hashCode), html.hashCode), download.hashCode),
        downloadLocation.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PhotoLinks')
          ..add('self', self)
          ..add('html', html)
          ..add('download', download)
          ..add('downloadLocation', downloadLocation))
        .toString();
  }
}

class PhotoLinksBuilder implements Builder<PhotoLinks, PhotoLinksBuilder> {
  _$PhotoLinks _$v;

  String _self;
  String get self => _$this._self;
  set self(String self) => _$this._self = self;

  String _html;
  String get html => _$this._html;
  set html(String html) => _$this._html = html;

  String _download;
  String get download => _$this._download;
  set download(String download) => _$this._download = download;

  String _downloadLocation;
  String get downloadLocation => _$this._downloadLocation;
  set downloadLocation(String downloadLocation) =>
      _$this._downloadLocation = downloadLocation;

  PhotoLinksBuilder();

  PhotoLinksBuilder get _$this {
    if (_$v != null) {
      _self = _$v.self;
      _html = _$v.html;
      _download = _$v.download;
      _downloadLocation = _$v.downloadLocation;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PhotoLinks other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PhotoLinks;
  }

  @override
  void update(void Function(PhotoLinksBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PhotoLinks build() {
    final _$result = _$v ??
        new _$PhotoLinks._(
            self: self,
            html: html,
            download: download,
            downloadLocation: downloadLocation);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
