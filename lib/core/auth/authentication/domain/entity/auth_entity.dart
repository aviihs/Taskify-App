class AuthEntity {
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
  final String? role;
  final bool? isEmailVerified;
  final bool? isActive;
  final String? token;
  final String? accessToken;
  final String? refreshToken;
  final String? otp;

  const AuthEntity({
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
    this.role,
    this.isEmailVerified,
    this.isActive,
    this.token,
    this.accessToken,
    this.refreshToken,
    this.otp,
  });

  bool get isAdmin => role?.toUpperCase() == 'ADMIN';
}
