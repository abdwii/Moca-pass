// To parse this JSON data, do
//
//     final gssoResponse = gssoResponseFromJson(jsonString);

import 'dart:convert';

GSSOResponse gssoResponseFromJson(String str) => GSSOResponse.fromJson(json.decode(str));

String gssoResponseToJson(GSSOResponse data) => json.encode(data.toJson());

class GSSOResponse {
    bool succeeded;
    dynamic message;
    dynamic errors;
    Data data;

    GSSOResponse({
        required this.succeeded,
        required this.message,
        required this.errors,
        required this.data,
    });

    factory GSSOResponse.fromJson(Map<String, dynamic> json) => GSSOResponse(
        succeeded: json["Succeeded"],
        message: json["Message"],
        errors: json["Errors"],
        data: Data.fromJson(json["Data"]),
    );

    Map<String, dynamic> toJson() => {
        "Succeeded": succeeded,
        "Message": message,
        "Errors": errors,
        "Data": data.toJson(),
    };
}

class Data {
    String email;
    String name;
    bool emailVerified;
    DateTime tokenExpiration;
    String jwtToken;
    String role;
    dynamic profileImage;

    Data({
        required this.email,
        required this.name,
        required this.emailVerified,
        required this.tokenExpiration,
        required this.jwtToken,
        required this.role,
        required this.profileImage,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["Email"],
        name: json["Name"],
        emailVerified: json["EmailVerified"],
        tokenExpiration: DateTime.parse(json["TokenExpiration"]),
        jwtToken: json["JWTToken"],
        role: json["Role"],
        profileImage: json["ProfileImage"],
    );

    Map<String, dynamic> toJson() => {
        "Email": email,
        "Name": name,
        "EmailVerified": emailVerified,
        "TokenExpiration": tokenExpiration.toIso8601String(),
        "JWTToken": jwtToken,
        "Role": role,
        "ProfileImage": profileImage,
    };
}
