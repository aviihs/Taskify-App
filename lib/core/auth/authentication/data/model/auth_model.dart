import 'package:taskify_app/core/auth/authentication/domain/entity/auth_entity.dart';

class AuthModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? userName;
  final String? dob;
  final String? gender;
  final String? bio;
  final num? phone;
  final String? password;
  final String? currentPassword;
  final String? newPassword;
  final String? avatar;
  final bool? isEmailVerified;
  final bool? isActive;
  final String? token;
  final String? accessToken;
  final String? refreshToken;
  final String? otp;

  const AuthModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.userName,
    this.dob,
    this.gender,
    this.bio,
    this.phone,
    this.password,
    this.currentPassword,
    this.newPassword,
    this.avatar,
    this.isEmailVerified,
    this.isActive,
    this.token,
    this.accessToken,
    this.refreshToken,
    this.otp,
  });

  factory AuthModel.fromEntity(AuthEntity entity) {
    return AuthModel(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      userName: entity.userName,
      dob: entity.dob,
      gender: entity.gender,
      bio: entity.bio,
      phone: entity.phone,
      password: entity.password,
      currentPassword: entity.currentPassword,
      newPassword: entity.newPassword,
      avatar: entity.avatar,
      isEmailVerified: entity.isEmailVerified,
      isActive: entity.isActive,
      token: entity.token,
      accessToken: entity.accessToken,
      refreshToken: entity.refreshToken,
      otp: entity.otp,
    );
  }

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    // Handle nested 'user' object if returned by login endpoint
    final userMap = json['user'] is Map<String, dynamic>
        ? json['user'] as Map<String, dynamic>
        : (json['data'] is Map<String, dynamic>
            ? json['data'] as Map<String, dynamic>
            : json);

    return AuthModel(
      id: (userMap['_id'] ?? userMap['id']) as String?,
      firstName: userMap['firstName'] as String?,
      lastName: userMap['lastName'] as String?,
      email: userMap['email'] as String?,
      userName: userMap['userName'] as String?,
      dob: userMap['dob'] as String?,
      gender: userMap['gender'] as String?,
      bio: userMap['bio'] as String?,
      phone: userMap['phone'] as num?,
      password: json['password'] as String?,
      currentPassword: json['currentPassword'] as String?,
      newPassword: json['newPassword'] as String?,
      avatar: userMap['avatar'] as String?,
      isEmailVerified: userMap['isEmailVerified'] as bool?,
      isActive: userMap['isActive'] as bool?,
      token: (json['accessToken'] ?? json['token']) as String?,
      accessToken: (json['accessToken'] ?? json['token']) as String?,
      refreshToken: json['refreshToken'] as String?,
      otp: json['otp'] as String?,
    );
  }

  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      userName: userName,
      dob: dob,
      gender: gender,
      bio: bio,
      phone: phone,
      password: password,
      currentPassword: currentPassword,
      newPassword: newPassword,
      avatar: avatar,
      isEmailVerified: isEmailVerified,
      isActive: isActive,
      token: accessToken ?? token,
      accessToken: accessToken ?? token,
      refreshToken: refreshToken,
      otp: otp,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (firstName != null) map['firstName'] = firstName;
    if (lastName != null) map['lastName'] = lastName;
    if (email != null) map['email'] = email;
    if (userName != null) map['userName'] = userName;
    if (dob != null) map['dob'] = dob;
    if (gender != null) map['gender'] = gender;
    if (bio != null) map['bio'] = bio;
    if (phone != null) map['phone'] = phone;
    if (password != null) map['password'] = password;
    if (currentPassword != null) map['currentPassword'] = currentPassword;
    if (newPassword != null) map['newPassword'] = newPassword;
    if (avatar != null) map['avatar'] = avatar;
    if (isEmailVerified != null) map['isEmailVerified'] = isEmailVerified;
    if (isActive != null) map['isActive'] = isActive;
    if (accessToken != null) map['accessToken'] = accessToken;
    if (refreshToken != null) map['refreshToken'] = refreshToken;
    if (token != null) map['token'] = token;
    if (otp != null) map['otp'] = otp;
    return map;
  }

  AuthModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? userName,
    String? dob,
    String? gender,
    String? bio,
    num? phone,
    String? password,
    String? currentPassword,
    String? newPassword,
    String? avatar,
    bool? isEmailVerified,
    bool? isActive,
    String? token,
    String? accessToken,
    String? refreshToken,
    String? otp,
  }) {
    return AuthModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      bio: bio ?? this.bio,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      avatar: avatar ?? this.avatar,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isActive: isActive ?? this.isActive,
      token: token ?? this.token,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      otp: otp ?? this.otp,
    );
  }
}
