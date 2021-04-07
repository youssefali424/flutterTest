// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<User> _$userSerializer = new _$UserSerializer();
Serializer<Address> _$addressSerializer = new _$AddressSerializer();
Serializer<Geo> _$geoSerializer = new _$GeoSerializer();

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
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'address',
      serializers.serialize(object.address,
          specifiedType: const FullType(Address)),
    ];

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
              specifiedType: const FullType(int)) as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'address':
          result.address.replace(serializers.deserialize(value,
              specifiedType: const FullType(Address)) as Address);
          break;
      }
    }

    return result.build();
  }
}

class _$AddressSerializer implements StructuredSerializer<Address> {
  @override
  final Iterable<Type> types = const [Address, _$Address];
  @override
  final String wireName = 'Address';

  @override
  Iterable<Object> serialize(Serializers serializers, Address object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'street',
      serializers.serialize(object.street,
          specifiedType: const FullType(String)),
      'suite',
      serializers.serialize(object.suite,
          specifiedType: const FullType(String)),
      'city',
      serializers.serialize(object.city, specifiedType: const FullType(String)),
      'zipcode',
      serializers.serialize(object.zipcode,
          specifiedType: const FullType(String)),
      'geo',
      serializers.serialize(object.geo, specifiedType: const FullType(Geo)),
    ];

    return result;
  }

  @override
  Address deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AddressBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'street':
          result.street = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'suite':
          result.suite = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'city':
          result.city = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'zipcode':
          result.zipcode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'geo':
          result.geo.replace(serializers.deserialize(value,
              specifiedType: const FullType(Geo)) as Geo);
          break;
      }
    }

    return result.build();
  }
}

class _$GeoSerializer implements StructuredSerializer<Geo> {
  @override
  final Iterable<Type> types = const [Geo, _$Geo];
  @override
  final String wireName = 'Geo';

  @override
  Iterable<Object> serialize(Serializers serializers, Geo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'lat',
      serializers.serialize(object.lat, specifiedType: const FullType(String)),
      'lng',
      serializers.serialize(object.lng, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Geo deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GeoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'lat':
          result.lat = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lng':
          result.lng = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$User extends User {
  @override
  final int id;
  @override
  final String name;
  @override
  final String username;
  @override
  final String email;
  @override
  final Address address;

  factory _$User([void Function(UserBuilder) updates]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._({this.id, this.name, this.username, this.email, this.address})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('User', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('User', 'name');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('User', 'username');
    }
    if (email == null) {
      throw new BuiltValueNullFieldError('User', 'email');
    }
    if (address == null) {
      throw new BuiltValueNullFieldError('User', 'address');
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
        name == other.name &&
        username == other.username &&
        email == other.email &&
        address == other.address;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), name.hashCode), username.hashCode),
            email.hashCode),
        address.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')
          ..add('id', id)
          ..add('name', name)
          ..add('username', username)
          ..add('email', email)
          ..add('address', address))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  AddressBuilder _address;
  AddressBuilder get address => _$this._address ??= new AddressBuilder();
  set address(AddressBuilder address) => _$this._address = address;

  UserBuilder();

  UserBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _username = _$v.username;
      _email = _$v.email;
      _address = _$v.address?.toBuilder();
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
              name: name,
              username: username,
              email: email,
              address: address.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'address';
        address.build();
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

class _$Address extends Address {
  @override
  final String street;
  @override
  final String suite;
  @override
  final String city;
  @override
  final String zipcode;
  @override
  final Geo geo;

  factory _$Address([void Function(AddressBuilder) updates]) =>
      (new AddressBuilder()..update(updates)).build();

  _$Address._({this.street, this.suite, this.city, this.zipcode, this.geo})
      : super._() {
    if (street == null) {
      throw new BuiltValueNullFieldError('Address', 'street');
    }
    if (suite == null) {
      throw new BuiltValueNullFieldError('Address', 'suite');
    }
    if (city == null) {
      throw new BuiltValueNullFieldError('Address', 'city');
    }
    if (zipcode == null) {
      throw new BuiltValueNullFieldError('Address', 'zipcode');
    }
    if (geo == null) {
      throw new BuiltValueNullFieldError('Address', 'geo');
    }
  }

  @override
  Address rebuild(void Function(AddressBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddressBuilder toBuilder() => new AddressBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Address &&
        street == other.street &&
        suite == other.suite &&
        city == other.city &&
        zipcode == other.zipcode &&
        geo == other.geo;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, street.hashCode), suite.hashCode), city.hashCode),
            zipcode.hashCode),
        geo.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Address')
          ..add('street', street)
          ..add('suite', suite)
          ..add('city', city)
          ..add('zipcode', zipcode)
          ..add('geo', geo))
        .toString();
  }
}

class AddressBuilder implements Builder<Address, AddressBuilder> {
  _$Address _$v;

  String _street;
  String get street => _$this._street;
  set street(String street) => _$this._street = street;

  String _suite;
  String get suite => _$this._suite;
  set suite(String suite) => _$this._suite = suite;

  String _city;
  String get city => _$this._city;
  set city(String city) => _$this._city = city;

  String _zipcode;
  String get zipcode => _$this._zipcode;
  set zipcode(String zipcode) => _$this._zipcode = zipcode;

  GeoBuilder _geo;
  GeoBuilder get geo => _$this._geo ??= new GeoBuilder();
  set geo(GeoBuilder geo) => _$this._geo = geo;

  AddressBuilder();

  AddressBuilder get _$this {
    if (_$v != null) {
      _street = _$v.street;
      _suite = _$v.suite;
      _city = _$v.city;
      _zipcode = _$v.zipcode;
      _geo = _$v.geo?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Address other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Address;
  }

  @override
  void update(void Function(AddressBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Address build() {
    _$Address _$result;
    try {
      _$result = _$v ??
          new _$Address._(
              street: street,
              suite: suite,
              city: city,
              zipcode: zipcode,
              geo: geo.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'geo';
        geo.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Address', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Geo extends Geo {
  @override
  final String lat;
  @override
  final String lng;

  factory _$Geo([void Function(GeoBuilder) updates]) =>
      (new GeoBuilder()..update(updates)).build();

  _$Geo._({this.lat, this.lng}) : super._() {
    if (lat == null) {
      throw new BuiltValueNullFieldError('Geo', 'lat');
    }
    if (lng == null) {
      throw new BuiltValueNullFieldError('Geo', 'lng');
    }
  }

  @override
  Geo rebuild(void Function(GeoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GeoBuilder toBuilder() => new GeoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Geo && lat == other.lat && lng == other.lng;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, lat.hashCode), lng.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Geo')
          ..add('lat', lat)
          ..add('lng', lng))
        .toString();
  }
}

class GeoBuilder implements Builder<Geo, GeoBuilder> {
  _$Geo _$v;

  String _lat;
  String get lat => _$this._lat;
  set lat(String lat) => _$this._lat = lat;

  String _lng;
  String get lng => _$this._lng;
  set lng(String lng) => _$this._lng = lng;

  GeoBuilder();

  GeoBuilder get _$this {
    if (_$v != null) {
      _lat = _$v.lat;
      _lng = _$v.lng;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Geo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Geo;
  }

  @override
  void update(void Function(GeoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Geo build() {
    final _$result = _$v ?? new _$Geo._(lat: lat, lng: lng);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
