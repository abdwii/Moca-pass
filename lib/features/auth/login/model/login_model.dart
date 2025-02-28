import 'dart:convert';

class LoginModel {
  String? email;
  String? name;
  bool? emailVerified;
  DateTime? tokenExpiration;
  String? jwtToken;
  String? role;
  String? profileImage;

  LoginModel({
    this.email,
    this.name,
    this.emailVerified,
    this.tokenExpiration,
    this.jwtToken,
    this.role,
    this.profileImage,
  });

  @override
  String toString() {
    return 'LoginModel(email: $email, name: $name, emailVerified: $emailVerified, tokenExpiration: $tokenExpiration, jwtToken: $jwtToken, role: $role, profileImage: $profileImage)';
  }

  factory LoginModel.fromMap(Map<String, dynamic> data) => LoginModel(
        email: data['Email'] as String?,
        name: data['Name'] as String?,
        emailVerified: data['EmailVerified'] as bool?,
        tokenExpiration: data['TokenExpiration'] == null
            ? null
            : DateTime.parse(data['TokenExpiration'] as String),
        jwtToken: data['JWTToken'] as String?,
        role: data['Role'] as String?,
        profileImage: data['ProfileImage'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'Email': email,
        'Name': name,
        'EmailVerified': emailVerified,
        'TokenExpiration': tokenExpiration?.toIso8601String(),
        'JWTToken': jwtToken,
        'Role': role,
        'ProfileImage': profileImage,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginModel].
  factory LoginModel.fromJson(String data) {
    return LoginModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginModel] to a JSON string.
  String toJson() => json.encode(toMap());

  LoginModel copyWith({
    String? email,
    String? name,
    bool? emailVerified,
    DateTime? tokenExpiration,
    String? jwtToken,
    String? role,
    String? profileImage,
  }) {
    return LoginModel(
      email: email ?? this.email,
      name: name ?? this.name,
      emailVerified: emailVerified ?? this.emailVerified,
      tokenExpiration: tokenExpiration ?? this.tokenExpiration,
      jwtToken: jwtToken ?? this.jwtToken,
      role: role ?? this.role,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
