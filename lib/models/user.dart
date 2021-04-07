import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  static Serializer<User> get serializer => _$userSerializer;

  /// Set of usernames to send the chat to, or empty to send to everyone.

  factory User([Function(UserBuilder) updates]) = _$User;

  User._();

  int get id;
  String get name;
  String get username;
  String get email;
  Address get address;
}

abstract class Address implements Built<Address, AddressBuilder> {
  static Serializer<Address> get serializer => _$addressSerializer;

  factory Address([Function(AddressBuilder) updates]) = _$Address;

  String get street;
  String get suite;
  String get city;
  String get zipcode;
  Geo get geo;
  Address._();
}

abstract class Geo implements Built<Geo, GeoBuilder> {
  static Serializer<Geo> get serializer => _$geoSerializer;

  factory Geo([Function(GeoBuilder) updates]) = _$Geo;
  Geo._();
  String get lat;
  String get lng;
}
