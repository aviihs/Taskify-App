import 'package:taskify_app/core/auth/authentication/domain/entity/auth_entity.dart';

class AuthModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? userName;
  final String? dob;
  final String? gender;
  final String? password;
  final String? currentPassword;
  final String? newPassword;
  final String? avatar;
  final bool? isEmailVerified;
  final bool? isActive;
  final String? token;
  final String? otp;

  const AuthModel({
    this.firstName,
    this.lastName,
    this.email,
    this.userName,
    this.dob,
    this.gender,
    this.password,
    this.currentPassword,
    this.newPassword,
    this.avatar,
    this.isEmailVerified,
    this.isActive,
    this.token,
    this.otp,
  });

  factory AuthModel.fromEntity(AuthEntity entity) {
    return AuthModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      userName: entity.userName,
      dob: entity.dob,
      gender: entity.gender,
      password: entity.password,
      currentPassword: entity.currentPassword,
      newPassword: entity.newPassword,
      avatar: entity.avatar,
      isEmailVerified: entity.isEmailVerified,
      isActive: entity.isActive,
      token: entity.token,
      otp: entity.otp,
    );
  }
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      userName: json['userName'] as String?,
      dob: json['dob'] as String?,
      gender: json['gender'] as String?,
      password: json['password'] as String?,
      currentPassword: json['currentPassword'] as String?,
      newPassword: json['newPassword'] as String?,
      avatar: json['avatar'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool?,
      isActive: json['isActive'] as bool?,
      token: json['token'] as String?,
      otp: json['otp'] as String?,
    );
  }
  AuthEntity toEntity() {
    return AuthEntity(
      firstName: firstName,
      lastName: lastName,
      email: email,
      userName: userName,
      dob: dob,
      gender: gender,
      password: password,
      currentPassword: currentPassword,
      newPassword: newPassword,
      avatar: avatar,
      isEmailVerified: isEmailVerified,
      isActive: isActive,
      token: token,
      otp: otp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'userName': userName,
      'dob': dob,
      'gender': gender,
      'password': password,
      'currentPassword': currentPassword,
      'newPassword': newPassword,
      'avatar': avatar,
      'isEmailVerified': isEmailVerified,
      'isActive': isActive,
      'token': token,
      'otp': otp,
    };
  }

  AuthModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? userName,
    String? dob,
    String? gender,
    String? password,
    String? currentPassword,
    String? newPassword,
    String? avatar,
    bool? isEmailVerified,
    bool? isActive,
    String? token,
    String? otp,
  }) {
    return AuthModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      password: password ?? this.password,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      avatar: avatar ?? this.avatar,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isActive: isActive ?? this.isActive,
      token: token ?? this.token,
      otp: otp ?? this.otp,
    );
  }
}
