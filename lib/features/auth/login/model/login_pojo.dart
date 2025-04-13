import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_pojo.g.dart';

@JsonSerializable()
class LoginPojo extends Equatable {
  LoginPojo({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.photo,
    required this.roles,
    required this.isVerified,
    required this.jwToken,
    required this.allClaims,
    required this.passEmail,
  });

  @JsonKey(name: 'Id')
  final String? id;
  static const String idKey = "Id";


  @JsonKey(name: 'UserName')
  final String? userName;
  static const String userNameKey = "UserName";


  @JsonKey(name: 'FirstName')
  final String? firstName;
  static const String firstNameKey = "FirstName";


  @JsonKey(name: 'LastName')
  final String? lastName;
  static const String lastNameKey = "LastName";


  @JsonKey(name: 'PhoneNumber')
  final String? phoneNumber;
  static const String phoneNumberKey = "PhoneNumber";


  @JsonKey(name: 'Email')
  final String? email;
  static const String emailKey = "Email";


  @JsonKey(name: 'Photo')
  final dynamic photo;
  static const String photoKey = "Photo";


  @JsonKey(name: 'Roles')
  final List<Role>? roles;
  static const String rolesKey = "Roles";


  @JsonKey(name: 'IsVerified')
  final bool? isVerified;
  static const String isVerifiedKey = "IsVerified";


  @JsonKey(name: 'JWToken')
  final String? jwToken;
  static const String jwTokenKey = "JWToken";


  @JsonKey(name: 'AllClaims')
  final List<AllClaim>? allClaims;
  static const String allClaimsKey = "AllClaims";


  @JsonKey(name: 'PassEmail')
  final dynamic passEmail;
  static const String passEmailKey = "PassEmail";


  LoginPojo copyWith({
    String? id,
    String? userName,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    dynamic? photo,
    List<Role>? roles,
    bool? isVerified,
    String? jwToken,
    List<AllClaim>? allClaims,
    dynamic? passEmail,
  }) {
    return LoginPojo(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      photo: photo ?? this.photo,
      roles: roles ?? this.roles,
      isVerified: isVerified ?? this.isVerified,
      jwToken: jwToken ?? this.jwToken,
      allClaims: allClaims ?? this.allClaims,
      passEmail: passEmail ?? this.passEmail,
    );
  }

  factory LoginPojo.fromJson(Map<String, dynamic> json) => _$LoginPojoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginPojoToJson(this);

  @override
  String toString(){
    return "$id, $userName, $firstName, $lastName, $phoneNumber, $email, $photo, $roles, $isVerified, $jwToken, $allClaims, $passEmail, ";
  }

  @override
  List<Object?> get props => [
    id, userName, firstName, lastName, phoneNumber, email, photo, roles, isVerified, jwToken, allClaims, passEmail, ];
}

@JsonSerializable()
class AllClaim extends Equatable {
  AllClaim({
    required this.claimType,
    required this.claimValue,
    required this.selected,
  });

  @JsonKey(name: 'ClaimType')
  final String? claimType;
  static const String claimTypeKey = "ClaimType";


  @JsonKey(name: 'ClaimValue')
  final String? claimValue;
  static const String claimValueKey = "ClaimValue";


  @JsonKey(name: 'Selected')
  final bool? selected;
  static const String selectedKey = "Selected";


  AllClaim copyWith({
    String? claimType,
    String? claimValue,
    bool? selected,
  }) {
    return AllClaim(
      claimType: claimType ?? this.claimType,
      claimValue: claimValue ?? this.claimValue,
      selected: selected ?? this.selected,
    );
  }

  factory AllClaim.fromJson(Map<String, dynamic> json) => _$AllClaimFromJson(json);

  Map<String, dynamic> toJson() => _$AllClaimToJson(this);

  @override
  String toString(){
    return "$claimType, $claimValue, $selected, ";
  }

  @override
  List<Object?> get props => [
    claimType, claimValue, selected, ];
}

@JsonSerializable()
class Role extends Equatable {
  Role({
    required this.roleName,
    required this.roleId,
  });

  @JsonKey(name: 'RoleName')
  final String? roleName;
  static const String roleNameKey = "RoleName";


  @JsonKey(name: 'RoleId')
  final String? roleId;
  static const String roleIdKey = "RoleId";


  Role copyWith({
    String? roleName,
    String? roleId,
  }) {
    return Role(
      roleName: roleName ?? this.roleName,
      roleId: roleId ?? this.roleId,
    );
  }

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);

  @override
  String toString(){
    return "$roleName, $roleId, ";
  }

  @override
  List<Object?> get props => [
    roleName, roleId, ];
}
