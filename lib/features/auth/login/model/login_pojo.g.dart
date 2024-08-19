// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_pojo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginPojo _$LoginPojoFromJson(Map<String, dynamic> json) => LoginPojo(
      id: json['Id'] as String?,
      userName: json['UserName'] as String?,
      firstName: json['FirstName'] as String?,
      lastName: json['LastName'] as String?,
      phoneNumber: json['PhoneNumber'] as String?,
      email: json['Email'] as String?,
      photo: json['Photo'],
      roles: (json['Roles'] as List<dynamic>?)
          ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
      isVerified: json['IsVerified'] as bool?,
      jwToken: json['JWToken'] as String?,
      allClaims: (json['AllClaims'] as List<dynamic>?)
          ?.map((e) => AllClaim.fromJson(e as Map<String, dynamic>))
          .toList(),
      passEmail: json['PassEmail'],
    );

Map<String, dynamic> _$LoginPojoToJson(LoginPojo instance) => <String, dynamic>{
      'Id': instance.id,
      'UserName': instance.userName,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'PhoneNumber': instance.phoneNumber,
      'Email': instance.email,
      'Photo': instance.photo,
      'Roles': instance.roles,
      'IsVerified': instance.isVerified,
      'JWToken': instance.jwToken,
      'AllClaims': instance.allClaims,
      'PassEmail': instance.passEmail,
    };

AllClaim _$AllClaimFromJson(Map<String, dynamic> json) => AllClaim(
      claimType: json['ClaimType'] as String?,
      claimValue: json['ClaimValue'] as String?,
      selected: json['Selected'] as bool?,
    );

Map<String, dynamic> _$AllClaimToJson(AllClaim instance) => <String, dynamic>{
      'ClaimType': instance.claimType,
      'ClaimValue': instance.claimValue,
      'Selected': instance.selected,
    };

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      roleName: json['RoleName'] as String?,
      roleId: json['RoleId'] as String?,
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'RoleName': instance.roleName,
      'RoleId': instance.roleId,
    };
