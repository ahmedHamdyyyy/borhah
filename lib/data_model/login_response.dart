// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.result,
    this.message,
    this.access_token,
    this.token_type,
    this.expires_at,
    this.user,
  });

  bool? result;
  var message;
  String? access_token;
  String? token_type;
  DateTime? expires_at;
  User? user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    result: json["result"],
    message: json["message"],
    access_token: json["access_token"] == null ? null : json["access_token"],
    token_type: json["token_type"] == null ? null : json["token_type"],
    expires_at: json["expires_at"] == null ? null : DateTime.parse(json["expires_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "access_token": access_token == null ? null : access_token,
    "token_type": token_type == null ? null : token_type,
    "expires_at": expires_at == null ? null : expires_at!.toIso8601String(),
    "user": user == null ? null : user!.toJson(),
  };
}

class User {
  User({
    this.id,
    this.type,
    this.name,
    this.email,
    this.avatar,
    this.avatar_original,
    this.phone, this.emailVerified,
  });

  int? id;
  String? type;
  String? name;
  String? email;
  String? avatar;
  String? avatar_original;
  String? phone;
  bool?emailVerified;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    type: json["type"],
    name: json["name"],
    email: json["email"],
    avatar: json["avatar"],
    avatar_original: json["avatar_original"],
    phone: json["phone"],
    emailVerified: json["email_verified"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "name": name,
    "email": email,
    "avatar": avatar,
    "avatar_original": avatar_original,
    "phone": phone,
    "email_verified": emailVerified,
  };
}

