import 'dart:convert';

class SessionModel {
  String userId;
  String token;
  String refreshToken;
  String verificationStatus;
  String verificationEnum;
  int expiry;
  SessionModel({
    this.userId,
    this.token,
    this.refreshToken,
    this.verificationStatus,
    this.verificationEnum,
    this.expiry,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'token': token,
      'verificationStatus': verificationStatus,
      'verificationSent': verificationEnum,
      'expiry': expiry,
      'refreshToken': refreshToken,
    };
  }

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    return SessionModel(
      userId: map['userId'],
      token: map['token'],
      refreshToken: map['refreshToken'],
      verificationStatus: map['verificationStatus'],
      verificationEnum: map['verificationSent'],
      expiry: map['expiry'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SessionModel.fromJson(String source) =>
      SessionModel.fromMap(json.decode(source));

  SessionModel copyWith({
    String userId,
    String token,
    String refreshToken,
    String verificationStatus,
    String verificationEnum,
    int expiry,
  }) {
    return SessionModel(
      userId: userId ?? this.userId,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      verificationEnum: verificationEnum ?? this.verificationEnum,
      expiry: expiry ?? this.expiry,
    );
  }
}
