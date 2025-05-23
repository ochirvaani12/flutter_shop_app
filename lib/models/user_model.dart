import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserModel {

  final int? id;
  final String? email;
  final String? username;
  final String? password;
  final String? phone;
  final Name? name;
  final Address? address;
  final int? v;

  UserModel({
    this.id,
    this.email,
    this.username,
    this.password,
    this.phone,
    this.name,
    this.address,
    this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  static List<UserModel> fromList(List<dynamic> data) =>
      data.map((e) => UserModel.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      phone: json['phone'] as String?,
      name: json['name'] == null
          ? null
          : Name.fromJson(json['name'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      v: json['__v'] as int?,
    );

@JsonSerializable()
class Name {
  final String? firstname;
  final String? lastname;

  Name({this.firstname, this.lastname});

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);
}

Name _$NameFromJson(Map<String, dynamic> json) => Name(
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
    );

@JsonSerializable()
class Address {
  final String? city;
  final String? street;
  final int? number;
  final String? zipcode;
  final GeoLocation? geolocation;

  Address(
      {this.city, this.street, this.number, this.zipcode, this.geolocation});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      city: json['city'] as String?,
      street: json['street'] as String?,
      number: json['number'] as int?,
      zipcode: json['zipcode'] as String?,
      geolocation: json['geolocation'] == null
          ? null
          : GeoLocation.fromJson(json['geolocation'] as Map<String, dynamic>),
    );

@JsonSerializable()
class GeoLocation {
  final String? lat;
  @JsonKey(name: 'long')
  final String? lng;

  GeoLocation({this.lat, this.lng});

  factory GeoLocation.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationFromJson(json);
}

GeoLocation _$GeoLocationFromJson(Map<String, dynamic> json) => GeoLocation(
      lat: json['lat'] as String?,
      lng: json['long'] as String?,
    );
